//
//  CadastroViewController.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import UIKit

protocol CadastroDisplayLogic: AnyObject {
    func displayScreenValues(viewModel: Cadastro.Model.ViewModel)
    func displaySuccess(viewModel: Cadastro.Model.SuccessViewModel)
    func displayError()
}

final class CadastroViewController: UIViewController {
    
    // MARK: - Archtecture Objects
    
    var interactor: CadastroBusinessLogic?
    var router: (NSObjectProtocol & CadastroRoutingLogic & CadastroDataPassing)?
    
    var screenView = CadastroView()
    
    // MARK: - ViewController Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func loadView() {
        view = screenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        screenView.delegate = viewController
    }
    
    // MARK: - Private Functions
    
    private func loadScreenValues() {
        interactor?.loadScreenValues()
    }
}

extension CadastroViewController: CadastroDelegate {
    
    func didTap() {
        interactor?.load()
    }
}

extension CadastroViewController: CadastroDisplayLogic {

    func displayScreenValues(viewModel: Cadastro.Model.ViewModel) {
        screenView.setup(model: viewModel.model)
    }
    
    func displaySuccess(viewModel: Cadastro.Model.SuccessViewModel) {
        print (viewModel.text)
    }
    
    func displayError() {
        print ("Erro")
        router?.routeToContato()
    }
}
