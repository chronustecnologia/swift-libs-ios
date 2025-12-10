//
//  CadastroInteractor.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import UIKit

protocol CadastroBusinessLogic {
    func loadScreenValues()
}

protocol CadastroDataStore {
    // var name: String { get set }
}

final class CadastroInteractor: CadastroBusinessLogic, CadastroDataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: CadastroPresentationLogic?
    let worker: CadastroWorkerLogic
    
    // MARK: - DataStore Objects
    
    // var name: String = ""
    
    // MARK: - Interactor Lifecycle
    
    init(worker: CadastroWorkerLogic = CadastroWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
}
