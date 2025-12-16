//
//  CadastroRoutingLogicSpy.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 16/12/25.
//

import Foundation
@testable import SwiftLibs

class CadastroRoutingLogicSpy: NSObject, CadastroRoutingLogic, CadastroDataPassing  {
    var dataStore: CadastroDataStore?
    
    var routeToContatoCalled = false
    
    func routeToContato() {
        routeToContatoCalled = true
    }
}
