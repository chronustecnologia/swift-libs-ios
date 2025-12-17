//
//  SLColor.swift
//  DSKit
//
//  Created by Jose Julio on 16/12/25.
//

import UIKit
import SLCommonImages

public class SLIconButton: UIButton, Themeable {
    
    private var sizeButton: CGFloat = 48
    private var paddingButton: CGFloat = 8
    
    public override var isHighlighted: Bool {
        didSet {
            if isHighlighted { 
                isHighlighted = false 
                } 
            setTheme(isHighlighted)
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            setTheme()
        }
    }
    
    public var isBackgroundClear: Bool = false {
        didSet {
            if isBackgroundClear {
                backgroundColor = .clear
            }
        }
    }
    
    public var theme: SLTheme = .light {
        didSet {
            self.tintColor = theme == .light ? SLColor.neutral100 : SLColor.neutral800
            setTheme()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: sizeButton, height: sizeButton)
    }
    
    public var iconName: String? {
        didSet {
            guard let nameString: String = iconName, 
                  let name = ImageNames.Literal(rawValue: nameString)  else { return }
            setImage(SLImage.fromImage(name), for: .normal)
        }
    }
    
    public init (size: CGFloat, padding: CGFloat) {
        super.init(frame: .zero)
        self.sizeButton = size
        self.paddingButton = padding
        setup()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        setupConstraints()
        setTheme()
        
        self.contentEdgeInsets = UIEdgeInsets(top: paddingButton, left: paddingButton, bottom: paddingButton, right: paddingButton)
        self.layer.cornerRadius = sizeButton / 2
        
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
    
    func setupConstraints() {
        self.snp.makeConstraints { make in
            make.width.height.equalTo(sizeButton).priority(999)
        }
    }
}
