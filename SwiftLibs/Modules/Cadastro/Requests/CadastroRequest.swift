//
//  CadastroRequest.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 15/12/25.
//

import SLCommonExtensions
import SLNetworkManager
import SLNetworkManagerInterface

final class CadastroRequest: NetworkRequestProtocol {
    var endpoint: String { "/typicode/demo/profile" }
    var method: HTTPMethod { .get }
    var body: [String: Any]? { request.toJSON() ?? [:] }
    
    var request: Cadastro.Model.Request
    
    init(request: Cadastro.Model.Request) {
        self.request = request
    }
}
