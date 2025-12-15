//
//  NetworkManagerProtocol.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

public protocol NetworkManagerProtocol {
    func request<T: Decodable>(_ request: NetworkRequest, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
    func request(_ request: NetworkRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
    func request(_ request: NetworkRequest,completion: @escaping (Result<Void, NetworkError>) -> Void)
    func request<T: Decodable>(_ request: NetworkRequest, responseType: T.Type) async throws -> T
    func request(_ request: NetworkRequest) async throws -> Data

    func request<T: Codable>(_ requestObject: NetworkRequestProtocol, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
    func request(_ requestObject: NetworkRequestProtocol, completion: @escaping (Result<Data, NetworkError>) -> Void)
    func request(_ requestObject: NetworkRequestProtocol, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func request<T: Decodable>(_ requestObject: NetworkRequestProtocol, responseType: T.Type) async throws -> T
    func request(_ requestObject: NetworkRequestProtocol) async throws -> Data
}
