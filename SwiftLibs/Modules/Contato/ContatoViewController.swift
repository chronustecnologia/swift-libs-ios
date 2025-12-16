//
//  ContatoViewController.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 16/12/25.
//

import UIKit

protocol ContatoDisplayLogic: AnyObject {
    func displayScreenValues(viewModel: Contato.Model.ViewModel)
}

final class ContatoViewController: UIViewController, ContatoDisplayLogic {
    
    // MARK: - Archtecture Objects
    
    var interactor: ContatoBusinessLogic?
    var router: (NSObjectProtocol & ContatoRoutingLogic & ContatoDataPassing)?
    
    // MARK: - ViewController Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = ContatoInteractor()
        let presenter = ContatoPresenter()
        let router = ContatoRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Private Functions
    
    private func loadScreenValues() {
        interactor?.loadScreenValues()
    }
    
    // MARK: - Layout Functions
    
    private func addComponents() {}
    
    private func addComponentsConstraints() {}
    
    // MARK: - Display Logic
    
    func displayScreenValues(viewModel: Contato.Model.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
