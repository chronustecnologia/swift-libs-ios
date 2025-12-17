//
//  SLButton.swift
//  DSKit
//
//  Created by Jose Julio on 25/11/25.
//

import UIKit
import SLCommonImages

public class SLButton: UIButton, Themeable {

    private var nextIcon: ImageNames.Literal = ImageNames.Literal.nextArrow

    public override var isHighlighted: Bool {
        didSet { if isHighlighted { isHighlighted = false } }
    }
    
    public override var isEnabled: Bool {
        didSet {
            setTheme()
        }
    }
    
    public var theme: SLTheme = .blue {
        didSet {
            setTheme()
        }
    }
    
    public var title: String? {
        get { titleLabel?.text }
        set {
            setTitle(newValue, for: .normal)
        }
    }
    
    public var hasNextIcon: Bool = false {
        didSet {
            guard hasNextIcon else {
                setImage(nil, for: .normal)
                return
            }
            let image: UIImage? = hasNextIcon ? SLImage.fromImage(nextIcon) : nil
            setImage(image, for: .normal)
            layoutSubviews()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        setStyle()
        setupConstraints()
        setTheme()
        self.addTarget(self, action: #selector(didTouchDown), for: .touchDown)
        self.addTarget(self, action: #selector(didTouchUp), for: .touchUpInside)
    }
    
    @objc func didTouchDown() {
        setTheme(true)
    }
    
    @objc func didTouchUp() {
        setTheme(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.setTheme()
            }, completion: nil)
        }
    }
    
    func setStyle() {
        layer.masksToBounds = true
        titleLabel?.font = SLFont.small
        setupMargins()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupMargins()
    }
    
    func setupMargins() {
        guard hasNextIcon else {
            contentEdgeInsets = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
            return
        }
        
        contentEdgeInsets = .zero
        imageEdgeInsets = UIEdgeInsets(top: 0, left: (bounds.width - 55), bottom: 0, right: 0)
        contentHorizontalAlignment = .left
        adjustsImageWhenHighlighted = false
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        titleLabel?.lineBreakMode = .byTruncatingTail
    }
    
    func setupConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(64).priority(.high)
            make.width.greaterThanOrEqualTo(100).priority(.high)
        }
    }
}
