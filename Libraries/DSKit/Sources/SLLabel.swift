//
//  SLLabel.swift
//  DSKit
//
//  Created by Jose Julio on 25/11/25.
//

import UIKit

public class SLLabel: UILabel, Themeable {
    
    public override var isEnabled: Bool {
        didSet {
            setTheme()
        }
    }
    
    public var theme: SLTheme = .light {
        didSet {
            setTheme()
        }
    }
    
    public override var text: String? {
        didSet {
            setParagraphStyle()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setTextStyle()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setTextStyle()
    }
    
    func setTextStyle() {
        font = SLFont.small
        numberOfLines = 0
        setParagraphStyle()
    }

    public override var bounds: CGRect {
          didSet {
              preferredMaxLayoutWidth = bounds.width
          }
      }
    
    func setParagraphStyle() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        paragraphStyle.alignment = self.textAlignment

        self.attributedText = NSMutableAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.kern: -0.32, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}