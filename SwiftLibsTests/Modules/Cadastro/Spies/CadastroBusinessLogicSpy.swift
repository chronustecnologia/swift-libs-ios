//
//  CadastroBusinessLogicSpy.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 16/12/25.
//

@testable import SwiftLibs

class CadastroBusinessLogicSpy: CadastroBusinessLogic {
    var loadScreenValuesCalled = false
    var loadCalled = false
    
    func loadScreenValues() {
        loadScreenValuesCalled = true
    }
    
    func load() {
        loadCalled = true
    }
}
