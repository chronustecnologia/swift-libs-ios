//
//  ContatoRouter.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 16/12/25.
//

import UIKit

@objc protocol ContatoRoutingLogic {
    func routeToSomewhere()
}

protocol ContatoDataPassing {
    var dataStore: ContatoDataStore? { get }
}

final class ContatoRouter: NSObject, ContatoRoutingLogic, ContatoDataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: ContatoViewController?
    var dataStore: ContatoDataStore?
    
    // MARK: - Routing Logic
    
    func routeToSomewhere() {
        //let nextController = NextViewController()
        //var destinationDS = nextController.router?.dataStore
        //passDataToSomewhere(source: dataStore, destination: &destinationDS)
        //viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - Passing data
    
    //func passDataToSomewhere(source: ContatoDataStore, destination: inout SomewhereDataStore) {
        //destination.name = source.name
    //}
}
