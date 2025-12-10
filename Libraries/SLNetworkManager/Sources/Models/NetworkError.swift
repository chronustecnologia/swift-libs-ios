//
//  NetworkError.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError(Error)
    case encodingError(Error)
    case httpError(statusCode: Int, data: Data?)
    case unauthorized
    case serverError(String)
    case networkError(Error)
    case unknown
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida"
        case .noData:
            return "Nenhum dado retornado"
        case .decodingError(let error):
            return "Erro ao decodificar resposta: \(error.localizedDescription)"
        case .encodingError(let error):
            return "Erro ao codificar requisição: \(error.localizedDescription)"
        case .httpError(let statusCode, _):
            return "Erro HTTP: \(statusCode)"
        case .unauthorized:
            return "Não autorizado"
        case .serverError(let message):
            return "Erro no servidor: \(message)"
        case .networkError(let error):
            return "Erro de rede: \(error.localizedDescription)"
        case .unknown:
            return "Erro desconhecido"
        }
    }
}