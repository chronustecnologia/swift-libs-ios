//
//  MockUtils.swift
//  Pods
//
//  Created by Jose Julio Junior on 10/12/25.
//

import Foundation

public protocol MockUtilsLogic {
    func configMockService(with config: MockConfigurationProtocol)
    func checkExistantMock(request: NetworkRequestProtocol) -> Data?
}

public final class MockUtils: MockUtilsLogic {
    
    // MARK: - Variables
    
    var mocksConfig: MockConfigurationProtocol?
    
    // MARK: - Objects
    
    let fileManager: FileManager
    
    // MARK: - Life Cycle
    
    public init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    // MARK: - Utils Logic
    
    public func configMockService(with config: MockConfigurationProtocol) {
        mocksConfig = config
    }
    
    public func checkExistantMock(request: NetworkRequestProtocol) -> Data? {
        guard let mocksConfig = mocksConfig,
              mocksConfig.mocksEnabled,
              !mocksConfig.mocksPath.isEmpty else { return nil }
        let path = request.endpoint.replacingOccurrences(of: "/", with: "_")
        return getMock(from: mocksConfig.mocksPath, and: path)
    }
    
    // MARK: - Private Functions
    
    private func getMock(from folder: String, and file: String) -> Data? {
        let fullPath = folder + file + ".json"
        guard fileManager.fileExists(atPath: fullPath),
              let contentData = try? String(contentsOfFile: fullPath, encoding: .utf8).data(using: .utf8) else { return nil }
        return contentData
    }
}
