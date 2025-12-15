//
//  CadastroInteractor.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import UIKit
import SLNetworkManagerInterface

protocol CadastroBusinessLogic {
    func loadScreenValues()
    func load()
}

protocol CadastroDataStore {
    var name: String { get set }
}

final class CadastroInteractor: CadastroBusinessLogic, CadastroDataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: CadastroPresentationLogic?
    let worker: CadastroWorkerLogic
    
    // MARK: - DataStore Objects
    
    var name: String = ""
    
    // MARK: - Interactor Lifecycle
    
    init(worker: CadastroWorkerLogic = CadastroWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
    
    func load() {
        let request = CadastroRequest(request: Cadastro.Model.Request(name: name, success: true))
        worker.fetch(request: request) { result in
            switch result {
            case .success(let response):
                self.handleSuccess(response)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func handleSuccess(_ response: Cadastro.Model.Response) {
        presenter?.presentSuccess(response: response)
    }
    
    private func handleError(_ error: NetworkError) {
        presenter?.presentError()
    }
}
