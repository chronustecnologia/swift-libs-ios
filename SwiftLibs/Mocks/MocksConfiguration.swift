//
//  MocksConfiguration.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import Foundation
import SLNetworkManager

final class MocksConfiguration: MockConfigurationProtocol {
    var mocksPath: String { "/Users/jose.julio.ext/BancoDigital/mobile-ios--banco-digital/BancoDigital/Mocks/" }
    var mocksEnabled: Bool {
        var isEnabled: Bool = false
    #if DEBUG
        isEnabled = true
    #endif
        return isEnabled
    }
}
