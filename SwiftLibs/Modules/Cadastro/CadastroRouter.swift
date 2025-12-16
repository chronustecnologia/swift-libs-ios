//
//  CadastroRouter.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import UIKit

@objc protocol CadastroRoutingLogic {
    func routeToContato()
}

protocol CadastroDataPassing {
    var dataStore: CadastroDataStore? { get }
}

final class CadastroRouter: NSObject, CadastroRoutingLogic, CadastroDataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: CadastroViewController?
    var dataStore: CadastroDataStore?
    
    // MARK: - Routing Logic
    
    func routeToContato() {
        let nextController = ContatoViewController()
        var destinationDS = nextController.router?.dataStore
        passDataToContato(source: dataStore, destination: &destinationDS)
        viewController?.navigationController?.pushViewController(nextController, animated: true)
    }
    
    // MARK: - Passing data
    
    func passDataToContato(source: CadastroDataStore?, destination: inout ContatoDataStore?) {
        destination?.name = source?.name ?? ""
    }
}
