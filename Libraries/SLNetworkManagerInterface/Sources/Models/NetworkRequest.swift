//
//  NetworkRequest.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

public struct NetworkRequest {
    public let endpoint: String
    public let method: HTTPMethod
    public let body: [String: Any]?
    public let headers: [String: String]?
    public let contentType: ContentType
    public let authentication: AuthenticationType
    
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
