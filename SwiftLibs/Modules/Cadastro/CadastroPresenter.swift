//
//  CadastroPresenter.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import UIKit

protocol CadastroPresentationLogic {
    func presentScreenValues()
}

final class CadastroPresenter: CadastroPresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: CadastroDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues() {
        let viewModel = Cadastro.Model.ViewModel()
        viewController?.displayScreenValues(viewModel: viewModel)
    }
}
