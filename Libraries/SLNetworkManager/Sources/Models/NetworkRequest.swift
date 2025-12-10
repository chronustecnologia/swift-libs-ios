//
//  NetworkRequest.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

public struct NetworkRequest {
    let endpoint: String
    let method: HTTPMethod
    let parameters: [String: Any]?
    let headers: [String: String]?
    let contentType: ContentType
    let authentication: AuthenticationType
    
    public init(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        contentType: ContentType = .json,
        authentication: AuthenticationType = .none
    ) {
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.contentType = contentType
        self.authentication = authentication
    }
}
