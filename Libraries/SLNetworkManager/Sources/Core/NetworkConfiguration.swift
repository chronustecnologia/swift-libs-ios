//
//  NetworkConfiguration.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

public struct NetworkConfiguration {
    let baseURL: String
    let defaultHeaders: [String: String]
    let timeoutInterval: TimeInterval
    let cachePolicy: URLRequest.CachePolicy
    let certificateValidation: CertificateValidation
    
    public init(
        baseURL: String,
        defaultHeaders: [String: String] = [:],
        timeoutInterval: TimeInterval = 30,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        certificateValidation: CertificateValidation
    ) {
        self.baseURL = baseURL
        self.defaultHeaders = defaultHeaders
        self.timeoutInterval = timeoutInterval
        self.cachePolicy = cachePolicy
        self.certificateValidation = certificateValidation
    }
}

public enum CertificateValidation {
    case `default`                               // Validação padrão do sistema
    case disabled                                // Desabilitar validação (apenas dev)
    case pinned(certificates: [Data])            // SSL Pinning com certificados específicos
    case custom(validator: CertificateValidator) // Validação customizada
}

public protocol CertificateValidator {
    func validate(trust: SecTrust, domain: String) -> Bool
}
