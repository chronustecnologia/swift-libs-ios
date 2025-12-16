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
    var spyWorker: CadastroWorkerLogicSpy?
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        spyPresenter = CadastroPresentationLogicSpy()
        spyWorker = CadastroWorkerLogicSpy()
        setupCadastroInteractor()
    }
    
    override func tearDown() {
        spyPresenter = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupCadastroInteractor() {
        sut = CadastroInteractor(worker: spyWorker!)
        sut?.presenter = spyPresenter
    }
    
    // MARK: - Tests
    
    func testPresentScreenValuesCalled() {
        // When
        sut?.loadScreenValues()
        
        // Then
        XCTAssertTrue(spyPresenter?.presentScreenValuesCalled ?? false)
    }
    
    func testPresentSuccessCalled() {
        // Given
        let response = Cadastro.Model.Response(name: "Jose")
        spyWorker?.fetchResponse = .success(response)
        
        // When
        let exp = self.expectation(for: NSPredicate(value: true), evaluatedWith: spyPresenter?.presentSuccessCalled ?? false, handler: .none)
        sut?.load()
        wait(for: [exp], timeout: 5.0)
        
        // Then
        XCTAssertTrue(spyPresenter?.presentSuccessCalled ?? false)
        XCTAssertTrue(spyWorker?.fetchCalled ?? false)
    }
    
    func testPresentErrorCalled() {
        // Given
        spyWorker?.fetchResponse = .failure(.invalidURL)
        
        // When
        let exp = self.expectation(for: NSPredicate(value: true), evaluatedWith: spyPresenter?.presentErrorCalled ?? false, handler: .none)
        sut?.load()
        wait(for: [exp], timeout: 5.0)
        
        // Then
        XCTAssertTrue(spyPresenter?.presentErrorCalled ?? false)
    }
}
