//
//  CadastroKeys.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 15/12/25.
//

import Foundation
import SLCommonExtensions

enum CadastroKeys {
    
    enum Localized: String, Localizable {
        case title
        
        var tableName: String { "Cadastro" }
        var bundle: Bundle? { .main }
    }
}
