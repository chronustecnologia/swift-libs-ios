//
//  SLTheme.swift
//  DSKit
//
//  Created by Jose Julio on 16/12/25.
//

import UIKit

public enum SLTheme: String {
    case light = "light"
    case dark = "dark"
    case blue = "blue"
    case green = "green"
    case red = "red"

    public var color: UIColor {
        switch self {
        case .light:
            return .white
        case .dark:
            return .black
        case .blue:
            return .blue
        case .green:
            return .green
        case .red:
            return .red
        }
    }
}

public protocol Themeable {
    var theme: SLTheme { get set }
    func setTheme(_ isPressed: Bool)
}

public extension Themeable where Self: UILabel {
    func setTheme(_ isPressed: Bool = false) {
        self.textColor = theme == .light ? SLColor.neutral100 : SLColor.neutral800
    }
}

public extension Themeable where Self: SLBottomModule {
    func setTheme(_ isPressed: Bool = false) {
        var backgroundColor: UIColor?
        var closeButtonTintiColor: UIColor?
        var closeButtonBackgroudColor: UIColor?
        var topViewBackgroudColor: UIColor?
        
        switch theme {
        case .light:
            backgroundColor = SLColor.neutral800
            closeButtonTintiColor = SLColor.neutral100
            closeButtonBackgroudColor = .clear
            topViewBackgroudColor = .clear
        case .blue:
            backgroundColor = SLColor.primary100
            closeButtonTintiColor = SLColor.neutral100
            closeButtonBackgroudColor = SLColor.primary100
            topViewBackgroudColor = SLColor.primary100
        case .dark:
            backgroundColor = SLColor.neutral100
            closeButtonTintiColor = SLColor.neutral800
            closeButtonBackgroudColor = SLColor.neutral100
            topViewBackgroudColor = SLColor.neutral100
        default:
            backgroundColor = SLColor.neutral800
            closeButtonTintiColor = SLColor.neutral100
            closeButtonBackgroudColor = .clear
            topViewBackgroudColor = .clear
        }
        
        self.closeButton.tintColor = closeButtonTintiColor
        self.closeButton.backgroundColor = closeButtonBackgroudColor
        self.scroll.backgroundColor = backgroundColor
        self.topView.backgroundColor = topViewBackgroudColor
    }
}

public extension Themeable where Self: SLIconButton {
    func setTheme(_ isPressed: Bool = false) {
        guard self.isEnabled else {
            self.tintColor = SLColor.neutral600
            return
        }
        
        var backgroundColor: UIColor?

        switch theme {
        case .blue:
            backgroundColor = isPressed ? SLColor.primary200 : (isBackgroundClear ? .clear : SLColor.primary100)
            tintColor = SLColor.neutral100
        case .dark:
            backgroundColor = isPressed ? SLColor.secondary200 : (isBackgroundClear ? .clear : SLColor.secondary100)
            tintColor = SLColor.neutral800
        case .red:
            backgroundColor = isPressed ?  SLColor.red200 :  (isBackgroundClear ? .clear : SLColor.red100)
        case .green:
            backgroundColor = isPressed ? SLColor.green200 : (isBackgroundClear ? .clear : SLColor.green100)
        case .light:
            backgroundColor = isPressed ? SLColor.neutral700 : (isBackgroundClear ? .clear : SLColor.neutral800)
        default:
            break
        }
        
        self.backgroundColor = backgroundColor
    }
}

public extension Themeable where Self: SLButton {
    func setTheme(_ isPressed: Bool = false) {
        guard self.isEnabled else {
            self.setTitleColor(SLColor.neutral300, for: .normal)
            self.backgroundColor = SLColor.neutral700
            return
        }
        
        var textColor: UIColor = SLColor.neutral800
        var backgroundColor: UIColor?
        
        switch theme {
        case .blue:
            backgroundColor = isPressed ? SLColor.primary200 : SLColor.primary100
        case .dark:
            backgroundColor = isPressed ? SLColor.secondary200 : SLColor.neutral100
        case .red:
            backgroundColor = isPressed ? SLColor.red200 : SLColor.red100
        case .green:
            backgroundColor = isPressed ? SLColor.green200 : SLColor.green100
        case .light:
            backgroundColor = isPressed ? SLColor.neutral700 : SLColor.neutral800
            textColor = SLColor.neutral100
        default:
            break
        }
        
        self.setTitleColor(textColor, for: .normal)
        self.imageView?.tintColor = textColor
        
        self.backgroundColor = backgroundColor
        self.tintColor = SLColor.neutral800
    }
}
