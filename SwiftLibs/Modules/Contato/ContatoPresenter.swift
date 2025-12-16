//
//  ContatoPresenter.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 16/12/25.
//

import UIKit

protocol ContatoPresentationLogic {
    func presentScreenValues()
}

final class ContatoPresenter: ContatoPresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: ContatoDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues() {
        let viewModel = Contato.Model.ViewModel()
        viewController?.displayScreenValues(viewModel: viewModel)
    }
}
