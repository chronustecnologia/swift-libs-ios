//
//  CadastroPresenterTests.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 16/12/25.
//

@testable import SwiftLibs
import XCTest

class CadastroPresenterTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: CadastroPresenter?
    var spyController: CadastroDisplayLogicSpy?
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        spyController = CadastroDisplayLogicSpy()
        setupCadastroPresenter()
    }
    
    override func tearDown() {
        spyController = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupCadastroPresenter() {
        sut = CadastroPresenter()
        sut?.viewController = spyController
    }
    
    // MARK: - Tests
    
    func testDisplayScreenValuesCalled() {
        
    }
    
    func testDisplaySuccessCalled() {
        
    }
    
    func testDisplayErrorCalled() {
        
    }
}
