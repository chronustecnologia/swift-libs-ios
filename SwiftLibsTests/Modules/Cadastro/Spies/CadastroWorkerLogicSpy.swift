//
//  CadastroWorkerLogicSpy.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 16/12/25.
//

@testable import SwiftLibs
import SLNetworkManagerInterface

class CadastroWorkerLogicSpy: CadastroWorkerLogic {
    var fetchCalled = false
    
    var fetchResponse: Result<Cadastro.Model.Response, NetworkError> = .failure(.unknown)
    
    func fetch(request: CadastroRequest, completion: @escaping (Result<Cadastro.Model.Response, NetworkError>) -> Void) {
        fetchCalled = true
        completion(fetchResponse)
    }
}
