//
//  ErrorsKeys.swift
//  SLCommonError
//
//  Created by Jose Julio on 25/11/25.
//

import Foundation
import SLCommonExtensions

public class BundleLocator {
    // Classe usada para obter o bundle do seu POD
}

public enum ErrorsKeys {
    public enum Localized: String, Localizable {
        case errorDefault

        public var tableName: String { "Errors" }
        public var bundle: Bundle? { Bundle(for: BundleLocator.self) }
    }
}
