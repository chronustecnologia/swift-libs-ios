//
//  String+Extensions.swift
//  SLCommonExtensions
//
//  Created by Jose Julio on 16/12/25.
//

import UIKit

extension UIView {

    public var hasSafeArea: Bool {
        guard #available(iOS 11.0, *),
              let s = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.safeAreaInsets else { return false }
        return s.top > 0 || s.bottom > 0 || s.left > 0 || s.right > 0
    }
    
    public var safeAreaHeightTop: CGFloat {
        guard #available(iOS 11.0, *),
              let s = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.safeAreaInsets else { return 0 }
        return s.top
    }
    
    public var safeAreaHeightBottom: CGFloat {
        guard #available(iOS 11.0, *),
              let s = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.safeAreaInsets else { return 0 }
        return s.bottom
    }

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    func removeAllSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
}