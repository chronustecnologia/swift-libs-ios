//
//  NetworkRequestProtocol.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

import Foundation

public protocol NetworkRequestProtocol {
    var endpoint: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: [String: Any]? { get }
    
    var headers: [String: String]? { get }
    
    var contentType: ContentType { get }
    
    var authentication: AuthenticationType { get }
    
    func asNetworkRequest() -> NetworkRequest
}

public extension NetworkRequestProtocol {
    func asNetworkRequest() -> NetworkRequest {
        return NetworkRequest(
            endpoint: endpoint,
            method: method,
            parameters: parameters,
            headers: headers,
            contentType: contentType,
            authentication: authentication
        )
    }
}