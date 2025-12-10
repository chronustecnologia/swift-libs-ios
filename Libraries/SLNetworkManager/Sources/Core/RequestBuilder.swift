//
//  RequestBuilder.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

final class RequestBuilder {
    
    private let configuration: NetworkConfiguration
    
    init(configuration: NetworkConfiguration) {
        self.configuration = configuration
    }
    
    func build(from request: NetworkRequest) throws -> URLRequest {
        // Construir URL completa
        let urlString = configuration.baseURL + request.endpoint
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.timeoutInterval = configuration.timeoutInterval
        urlRequest.cachePolicy = configuration.cachePolicy
        
        // Adicionar headers padrão
        configuration.defaultHeaders.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        // Adicionar Content-Type
        urlRequest.setValue(request.contentType.headerValue, forHTTPHeaderField: "Content-Type")
        
        // Adicionar autenticação
        if let authValue = request.authentication.headerValue {
            urlRequest.setValue(authValue, forHTTPHeaderField: "Authorization")
        }
        
        // Adicionar headers customizados (sobrescreve os padrões se necessário)
        request.headers?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        // Adicionar body se necessário
        if let parameters = request.body, request.method != .get {
            do {
                urlRequest.httpBody = try encodeParameters(parameters, contentType: request.contentType)
            } catch {
                throw NetworkError.encodingError(error)
            }
        } else if let parameters = request.body, request.method == .get {
            // Para GET, adicionar parâmetros na query string
            urlRequest.url = try addQueryParameters(to: url, parameters: parameters)
        }
        
        return urlRequest
    }
    
    private func encodeParameters(_ parameters: [String: Any], contentType: ContentType) throws -> Data {
        switch contentType {
        case .json:
            return try JSONSerialization.data(withJSONObject: parameters, options: [])
        case .formUrlEncoded:
            return encodeFormUrlEncoded(parameters)
        case .multipartFormData:
            // Implementação básica - pode ser expandida
            return try JSONSerialization.data(withJSONObject: parameters, options: [])
        }
    }
    
    private func encodeFormUrlEncoded(_ parameters: [String: Any]) -> Data {
        let parameterArray = parameters.map { key, value -> String in
            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "\(value)"
            return "\(escapedKey)=\(escapedValue)"
        }
        
        let bodyString = parameterArray.joined(separator: "&")
        return bodyString.data(using: .utf8) ?? Data()
    }
    
    private func addQueryParameters(to url: URL, parameters: [String: Any]) throws -> URL {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw NetworkError.invalidURL
        }
        
        components.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        
        guard let finalURL = components.url else {
            throw NetworkError.invalidURL
        }
        
        return finalURL
    }
}
