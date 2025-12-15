//
//  CadastroModels.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import UIKit

enum Cadastro {
    enum Model {
        struct Request: Codable {
            let name: String
            let success: Bool
        }
        struct Response: Codable {
            let name: String?
        }
        struct ViewModel {
            let model: CadastroModel
        }
        struct SuccessViewModel {
            let text: String
        }
    }
}
