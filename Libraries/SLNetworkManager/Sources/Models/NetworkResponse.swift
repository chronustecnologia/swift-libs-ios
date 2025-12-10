//
//  NetworkResponse.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

public struct NetworkResponse<T> {
    public let data: T
    public let statusCode: Int
    public let headers: [AnyHashable: Any]?
    
    public init(data: T, statusCode: Int, headers: [AnyHashable: Any]?) {
        self.data = data
        self.statusCode = statusCode
        self.headers = headers
    }
}