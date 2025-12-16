//
//  CadastroWorkerTests.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 16/12/25.
//

@testable import SwiftLibs
import XCTest

class CadastroWorkerTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: CadastroWorker?
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupCadastroWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupCadastroWorker() {
        sut = CadastroWorker()
    }
    
    // MARK: - Tests
    
    func testSomething() {
        // Given
        
        // When
        
        // Then
    }
}
