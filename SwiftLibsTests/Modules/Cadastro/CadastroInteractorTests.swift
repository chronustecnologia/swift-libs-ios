//
//  CadastroInteractorTests.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 16/12/25.
//

@testable import SwiftLibs
import XCTest

class CadastroInteractorTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: CadastroInteractor?
    var spyPresenter: CadastroPresentationLogicSpy?
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        spyPresenter = CadastroPresentationLogicSpy()
        setupCadastroInteractor()
    }
    
    override func tearDown() {
        spyPresenter = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupCadastroInteractor() {
        sut = CadastroInteractor()
        sut?.presenter = spyPresenter
    }
    
    // MARK: - Tests
    
    func testPresentScreenValuesCalled() {
        
    }
    
    func testPresentSuccessCalled() {
        
    }
    
    func testPresentErrorCalled() {
        
    }
}
