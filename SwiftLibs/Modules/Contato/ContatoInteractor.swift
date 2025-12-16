//
//  ContatoInteractor.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 16/12/25.
//

import UIKit

protocol ContatoBusinessLogic {
    func loadScreenValues()
}

protocol ContatoDataStore {
    var name: String { get set }
}

final class ContatoInteractor: ContatoBusinessLogic, ContatoDataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: ContatoPresentationLogic?
    let worker: ContatoWorkerLogic
    
    // MARK: - DataStore Objects
    
    var name: String = ""
    
    // MARK: - Interactor Lifecycle
    
    init(worker: ContatoWorkerLogic = ContatoWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
}
