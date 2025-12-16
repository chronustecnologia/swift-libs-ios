//
//  CadastroViewControllerTests.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 16/12/25.
//

@testable import SwiftLibs
import XCTest

class CadastroViewControllerTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: CadastroViewController?
    var spyInteractor: CadastroBusinessLogicSpy?
    var spyRouter: CadastroRoutingLogicSpy?
    var window: UIWindow?
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        spyInteractor = CadastroBusinessLogicSpy()
        spyRouter = CadastroRoutingLogicSpy()
        setupCadastroViewController()
    }
    
    override func tearDown() {
        window = nil
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupCadastroViewController() {
        sut = CadastroViewController()
        sut?.interactor = spyInteractor
        sut?.router = spyRouter
    }
    
    func loadView() {
        guard let sut = sut else { return }
        window?.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Tests
    
    func testLoadScreenValuesCalled() {
        
    }
    
    func testLoadCalled() {
        
    }
    
    func testRouteToContatoCalled() {
        
    }
}
