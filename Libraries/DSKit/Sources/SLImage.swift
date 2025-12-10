//
//  SLImage.swift
//  DSKit
//
//  Created by Jose Julio on 25/11/25.
//

import UIKit
import SLCommonImages

public class SLImage: NSObject {
    
    public static func fromImage(data: Data) -> UIImage? {
        return UIImage(data: data)
    }

    public static func fromImage(_ name: ImageNames.Literal) -> UIImage? {
        return UIImage(named: name.rawValue, in: Bundle(for: SLImage.self), compatibleWith: nil)
    }
    
    @available(iOS 13.0, *)
    public static func fromImage(named name: String, config: UIImage.Configuration?) -> UIImage? {
        return UIImage(named: name, in: Bundle(for: SLImage.self), with: config)
    }
}
