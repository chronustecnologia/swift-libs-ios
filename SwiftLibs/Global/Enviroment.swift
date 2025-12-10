//
//  Enviroment.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import SLNetworkManager

public enum Environment {
    case development
    case staging
    case production
    
    /// Retorna o ambiente atual baseado em configurações
    static var current: Environment {
        #if DEBUG
        return .development
        #elseif STAGING
        return .staging
        #else
        return .production
        #endif
    }
    
    var baseURL: String {
        switch self {
        case .development:
            return "https://my-json-server.typicode.com"
        case .staging:
            return "https://my-json-server.typicode.com"
        case .production:
            return "https://my-json-server.typicode.com"
        }
    }
    
    var isLoggingEnabled: Bool {
        switch self {
        case .development, .staging:
            return true
        case .production:
            return false
        }
    }
    
    var certificateValidation: CertificateValidation {
        switch self {
        case .development:
            // Em desenvolvimento, aceitar certificados auto-assinados
            return .disabled
            
        case .staging:
            // Em staging, pode usar pinning ou validação padrão
            return .default
            
        case .production:
            // Em produção, SEMPRE usar SSL Pinning
            if let certificates = loadProductionCertificates() {
                return .pinned(certificates: certificates)
            }
            return .default
        }
    }
    
    private func loadProductionCertificates() -> [Data]? {
        var certificates: [Data] = []
        
        let resource = baseURL.replacingOccurrences(of: "https://", with: "")
        if let certPath = Bundle.main.path(forResource: resource, ofType: "cer"),
           let certData = try? Data(contentsOf: URL(fileURLWithPath: certPath)) {
            certificates.append(certData)
        }
        
        return certificates.isEmpty ? nil : certificates
    }
}
