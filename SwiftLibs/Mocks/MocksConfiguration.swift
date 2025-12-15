//
//  MocksConfiguration.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import Foundation
import SLNetworkManager
import SLNetworkManagerInterface

final class MocksConfiguration: MockConfigurationProtocol {
    var mocksPath: String { "/Users/jose.julio.ext/SwiftProjects/swift-libs-ios/SwiftLibs/Mocks/" }
    var mocksEnabled: Bool {
        var isEnabled: Bool = false
    #if DEBUG
        isEnabled = true
    #endif
        return isEnabled
    }
}
