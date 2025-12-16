//
//  CadastroDisplayLogicSpy.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 16/12/25.
//

@testable import SwiftLibs

class CadastroDisplayLogicSpy: CadastroDisplayLogic {
    var displayScreenValuesCalled = false
    var displaySuccessCalled = false
    var displayErrorCalled = false
    
    func displayScreenValues(viewModel: Cadastro.Model.ViewModel) {
        displayScreenValuesCalled = true
    }
    
    func displaySuccess(viewModel: Cadastro.Model.SuccessViewModel) {
        displaySuccessCalled = true
    }
    
    func displayError() {
        displayErrorCalled = true
    }
}
