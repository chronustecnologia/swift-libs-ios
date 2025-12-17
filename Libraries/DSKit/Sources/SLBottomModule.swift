//
//  SLBottomModule.swift
//  DSKit
//
//  Created by Jose Julio on 16/12/25.
//

import Foundation
import UIKit
import SnapKit
import SLCommonExtensions

public protocol SLBottomModuleDelegate: AnyObject {
    func didTapButton()
    func didCloseAlert()
    func didScrollView(_ scrollView: UIScrollView) -> Void
}

open class SLBottomModule: UIView, Themeable {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = SLColor.white
        view.alpha = kBackgroundAlpha
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    public lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = kCornerRadius
        view.layer.maskedCorners = kTopCornersMask
        return view
    }()
    
    public lazy var topView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = kCornerRadius
        view.layer.maskedCorners = kTopCornersMask
        view.backgroundColor = .clear
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(alertDrag))
        view.addGestureRecognizer(panGestureRecognizer)
        return view
    }()
    
    public lazy var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .white
        scroll.layer.cornerRadius = kCornerRadius
        scroll.layer.maskedCorners = kTopCornersMask
        scroll.delegate = self
        scroll.isScrollEnabled = true
        return scroll
    }()

    public lazy var closeButton: SLIconButton = {
        let button = SLIconButton()
        button.iconName = "close"
        button.theme = .light
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()
    
    public var theme: SLTheme = .light {
        didSet {
            setTheme()
        }
    }

    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    private let kTopCornersMask: CACornerMask = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    private let kCornerRadius: CGFloat = 24.0
    private let kBackgroundAlpha: CGFloat = 0.8
    private let kAlertInset: CGFloat = 8.0
    private let kDragLimit: CGFloat = 1/3
    private let kTopTrailingCloseButton: CGFloat = 10.0
    private let kTopViewHeight: CGFloat = 80.0
    private let kSizeCondition: CGFloat = 32.0

    public weak var delegate: SLBottomModuleDelegate?
    public var parentView: UIView?
    
    private var dragY: CGFloat = 0.0
    private var alertBottom: CGFloat = 0
    private var isClosingByUser = false
    private var withView = UIView()
    private var useScrollView = true

    public convenience init(withView: UIView, useScrollView: Bool = true) {
        self.init(frame: UIScreen.main.bounds)
        self.useScrollView = useScrollView
        setupLayout(withView)
    }
    
    @objc func didTapClose() {
        isClosingByUser = true
        hide(callDelegate: true)
    }
    
    @objc func didTapBackground(_ gesture: UITapGestureRecognizer) {
        hide()
    }

    @objc func alertDrag(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        switch gesture.state {
        case .began:
            dragY = kAlertInset
        case .changed:
            let const = dragY - translation.y
            if const > dragY { return }
            mainView.snp.updateConstraints { update in
                update.bottom.equalToSuperview().inset(const)
            }
            alertBottom = const
            backgroundView.alpha = kBackgroundAlpha - (abs(const) / mainView.frame.size.height)
            mainView.layoutIfNeeded()
        case .ended:
            if abs(alertBottom) < (mainView.frame.size.height * kDragLimit) {
                show()
            } else {
                hide()
            }
        default:
            return
        }
    }
    
    public func show() {
        guard let parentView = UIApplication.shared.keyWindow else { return }
        
        self.frame = UIScreen.main.bounds
        parentView.addSubview(self)
        
        if withView.frame.height == 0 {
            withView.translatesAutoresizingMaskIntoConstraints = false
            withView.setNeedsLayout()
            withView.layoutIfNeeded()
        }
        
        let alertHeight = withView.frame.height
        
        setupMainView(bottomContraint: alertHeight, heightConstraint: getHeight(alertHeight))
        setupWithView()
        setupScrollView()
        setupTopView()
        
        backgroundView.alpha = 0
        self.layoutIfNeeded()
        animate()
    }
    
    public func animate() {
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundView.alpha = self.kBackgroundAlpha
            self.mainView.snp.updateConstraints { update in
                update.bottom.equalToSuperview()
            }
            self.layoutIfNeeded()
        })
    }
    
    public func hide(callDelegate: Bool = true) {
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundView.alpha = 0
            let alertHeight = self.mainView.frame.height
            self.mainView.snp.updateConstraints { update in
                update.bottom.equalToSuperview().inset(-alertHeight)
            }
            self.layoutIfNeeded()
        }, completion: { _ in
            self.removeFromSuperview()
            if callDelegate {
                if self.isClosingByUser {
                    self.delegate?.didCloseAlert()
                }
                self.isClosingByUser = false
            }
        })
    }
    
    public func updateConstraintsWithView() {
        withView.layoutIfNeeded()
        let alertHeight = withView.frame.height + kSizeCondition
        let heightConstraint = getHeight(alertHeight)
        
        mainView.snp.updateConstraints({ make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(0)
            make.width.equalTo(screenWidth)
            make.height.equalTo(heightConstraint)
        })
    }
    
    // MARK: - Private methods
    
    private func setupLayout(_ withView: UIView) {
        self.withView = withView
        accessibilityViewIsModal = true
        setuptBackgraoundView()
    }
    
    private func setupWithView() {
        let parentView = useScrollView ? scroll : mainView
        parentView.addSubview(withView)
        withView.layer.cornerRadius = kCornerRadius
        withView.layer.maskedCorners = kTopCornersMask
        
        withView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.width.equalToSuperview()
        }
    }
    
    private func setupMainView(bottomContraint: CGFloat, heightConstraint: CGFloat) {
        addSubview(mainView)
        bringSubviewToFront(mainView)
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(-bottomContraint)
            make.width.equalTo(screenWidth)
            make.height.equalTo(heightConstraint)
        }
    }
    
    private func setuptBackgraoundView() {
        insertSubview(backgroundView, at: 0)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundView.alpha = 0
    }
    
    private func setupTopView() {
        mainView.addSubview(topView)
        mainView.bringSubviewToFront(topView)
        topView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(kTopViewHeight)
        }
        
        topView.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(kTopTrailingCloseButton)
        }
    }
    
    private func setupScrollView() {
        guard useScrollView else { return }
        mainView.addSubview(scroll)
        scroll.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.height.equalToSuperview()
            make.width.equalTo(screenWidth)
        }
    }
    
    private func getHeight(_ withViewHeightSize: CGFloat) -> CGFloat {
        let screenConditional = screenHeight - (kSizeCondition + safeAreaHeightBottom)
        return (withViewHeightSize) > screenConditional ? screenConditional : withViewHeightSize
    }
}

extension SLBottomModule: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.didScrollView(scrollView)
        UIView.animate(withDuration: 0.5, animations: {
            if scrollView.contentOffset.y > 3 {
                self.topView.alpha = 0.96
            } else {
                self.topView.alpha = 1
            }
        })
        self.layoutIfNeeded()
    }
}
