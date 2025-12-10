//
//  CadastroRouter.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import UIKit

@objc protocol CadastroRoutingLogic {
    func routeToSomewhere()
}

protocol CadastroDataPassing {
    var dataStore: CadastroDataStore? { get }
}

final class CadastroRouter: NSObject, CadastroRoutingLogic, CadastroDataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: CadastroViewController?
    var dataStore: CadastroDataStore?
    
    // MARK: - Routing Logic
    
    func routeToSomewhere() {
        //let nextController = NextViewController()
        //var destinationDS = nextController.router?.dataStore
        //passDataToSomewhere(source: dataStore, destination: &destinationDS)
        //viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - Passing data
    
    //func passDataToSomewhere(source: CadastroDataStore, destination: inout SomewhereDataStore) {
        //destination.name = source.name
    //}
}
