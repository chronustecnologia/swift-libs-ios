//
//  MockConfigurationProtocol.swift
//  Pods
//
//  Created by Jose Julio Junior on 10/12/25.
//

import Foundation

public protocol MockConfigurationProtocol {
    var mocksPath: String { get }
    var mocksEnabled: Bool { get }
}
