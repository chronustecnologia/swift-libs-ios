//
//  CadastroPresentationLogicSpy.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 16/12/25.
//

@testable import SwiftLibs

class CadastroPresentationLogicSpy: CadastroPresentationLogic {
    var presentScreenValuesCalled = false
    var presentSuccessCalled = false
    var presentErrorCalled = false
    
    func presentScreenValues() {
        presentScreenValuesCalled = true
    }
    
    func presentSuccess(response: Cadastro.Model.Response) {
        presentSuccessCalled = true
    }
    
    func presentError() {
        presentErrorCalled = true
    }
}
