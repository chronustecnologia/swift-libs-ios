//
//  BaseNetworkRequest.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import SLNetworkManager
import SLNetworkManagerInterface

open class BaseNetworkRequest: NetworkRequestProtocol {
    
    public var endpoint: String {
        fatalError("Endpoint deve ser implementado pela subclasse")
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var parameters: [String: Any]? {
        return nil
    }
    
    public var headers: [String: String]? {
        ["user-agent": "app"]
    }
    
    public var contentType: ContentType {
        return .json
    }
    
    public var authentication: AuthenticationType {
        return .none
    }
    
    public init() {}
}
