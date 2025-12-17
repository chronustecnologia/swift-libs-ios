//
//  SLFont.swift
//  DSKit
//
//  Created by Jose Julio on 25/11/25.
//

import UIKit
import Foundation

public class SLFont: NSObject {

    public static let large = font(type: .book, size: .large)    
    public static let largeHighlight = font(type: .bold, size: .large)
    
    public static let medium = font(type: .book, size: .medium)
    public static let mediumHighlight = font(type: .bold, size: .medium)

    public static let small = font(type: .book, size: .small)
    public static let smallHighlight = font(type: .bold, size: .small)
    
    public static let tiny = font(type: .book, size: .tiny)
    public static let tinyHighlight = font(type: .bold, size: .tiny)
    
    public static let caption = font(type: .book, size: .caption)
    public static let captionHighlight = font(type: .bold, size: .caption)
    
    public enum FontType: String {
        case book = "Avenir"
        case bold = "Avenir-Bold"
    }
    
    public enum FontSize {
        case caption
        case tiny
        case small
        case medium
        case large
        case custom(size: CGFloat)
        
        public var rawValue: CGFloat {
            switch self {
            case .caption:
                return 12
            case .tiny:
                return 16
            case .small:
                return 18
            case .medium:
                return 24
            case .large:
                return 32
            case .custom(let size):
                return size
            }
        }
    }
    
    public static func font(type: FontType, size: FontSize) -> UIFont {
        return UIFont(name: type.rawValue, size: size.rawValue) ?? UIFont()
    }
    
    static func loadFontWith(name: String, type: String = "otf") {
        let frameworkBundle = Bundle(for: SLFont.self)
        let pathForResourceString = frameworkBundle.path(forResource: name, ofType: type)
        let fontData = NSData(contentsOfFile: pathForResourceString!)
        let dataProvider = CGDataProvider(data: fontData!)
        let fontRef = CGFont(dataProvider!)
        var errorRef: Unmanaged<CFError>? = nil

        if (CTFontManagerRegisterGraphicsFont(fontRef!, &errorRef) == false) {
            NSLog("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }
}
