//
//  CadastroPresenter.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import UIKit

protocol CadastroPresentationLogic {
    func presentScreenValues()
    func presentSuccess(response: Cadastro.Model.Response)
    func presentError()
}

final class CadastroPresenter: CadastroPresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: CadastroDisplayLogic?
    var localized = CadastroKeys.Localized.self
    
    // MARK: - Presentation Logic
    
    func presentScreenValues() {
        let viewModel = Cadastro.Model.ViewModel(
            model: CadastroModel(button: localized.title.string())
        )
        viewController?.displayScreenValues(viewModel: viewModel)
    }
    
    func presentSuccess(response: Cadastro.Model.Response) {
        let viewModel = Cadastro.Model.SuccessViewModel(text: response.name ?? "")
        viewController?.displaySuccess(viewModel: viewModel)
    }
    
    func presentError() {
        viewController?.displayError()
    }
}
