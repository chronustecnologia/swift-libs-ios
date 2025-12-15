//
//  AuthenticationType.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

import Foundation

public enum AuthenticationType {
    case none
    case basic(username: String, password: String)
    case bearer(token: String)
    
    public var headerValue: String? {
        switch self {
        case .none:
            return nil
        case .basic(let username, let password):
            let credentials: String = "\(username):\(password)"
            guard let data = credentials.data(using: .utf8) else { return nil }
            return "Basic \(data.base64EncodedString())"
        case .bearer(let token):
            return "Bearer \(token)"
        }
    }
}
