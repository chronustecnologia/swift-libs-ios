//
//  CadastroViewController.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import UIKit

protocol CadastroDisplayLogic: AnyObject {
    func displayScreenValues(viewModel: Cadastro.Model.ViewModel)
}

final class CadastroViewController: UIViewController, CadastroDisplayLogic {
    
    // MARK: - Archtecture Objects
    
    var interactor: CadastroBusinessLogic?
    var router: (NSObjectProtocol & CadastroRoutingLogic & CadastroDataPassing)?
    
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
        let interactor = CadastroInteractor()
        let presenter = CadastroPresenter()
        let router = CadastroRouter()
        
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
    
    func displayScreenValues(viewModel: Cadastro.Model.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
