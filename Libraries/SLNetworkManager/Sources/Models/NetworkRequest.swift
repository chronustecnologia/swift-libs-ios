//
//  NetworkRequest.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

public struct NetworkRequest {
    let endpoint: String
    let method: HTTPMethod
    let body: [String: Any]?
    let headers: [String: String]?
    let contentType: ContentType
    let authentication: AuthenticationType
    
    public init(
        endpoint: String,
        method: HTTPMethod,
        body: [String: Any]? = nil,
        headers: [String: String]? = nil,
        contentType: ContentType = .json,
        authentication: AuthenticationType = .none
    ) {
        self.endpoint = endpoint
        self.method = method
        self.body = body
        self.headers = headers
        self.contentType = contentType
        self.authentication = authentication
    }
}
