//
//  CadastroWorker.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import UIKit
import SLNetworkManager
import SLNetworkManagerInterface

protocol CadastroWorkerLogic {
    func fetch(request: CadastroRequest, completion: @escaping (Result<Cadastro.Model.Response, NetworkError>) -> Void)
}

final class CadastroWorker: CadastroWorkerLogic {
    var networkManager: NetworkManagerProtocol?
    
    init (networkManager: NetworkManagerProtocol? = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetch(request: CadastroRequest, completion: @escaping (Result<Cadastro.Model.Response, NetworkError>) -> Void) {
        self.networkManager?.request(request, responseType: Cadastro.Model.Response.self, completion: completion)
    }
}
