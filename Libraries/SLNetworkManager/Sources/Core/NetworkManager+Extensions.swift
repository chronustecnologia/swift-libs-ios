//
//  NetworkManager+Extensions.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

public extension NetworkManager {
    
    func request<T: Codable>(
        _ requestObject: NetworkRequestProtocol,
        responseType: T.Type,
        decoder: JSONDecoder = JSONDecoder(),
        completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard continueWithoutMock(model: responseType, request: requestObject, customError: EmptyErrorModel.self, completion: completion) else { return }
        let networkRequest = requestObject.asNetworkRequest()
        self.request(networkRequest, responseType: responseType, decoder: decoder, completion: completion)
    }
    
    func request(
        _ requestObject: NetworkRequestProtocol,
        completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let networkRequest = requestObject.asNetworkRequest()
        self.request(networkRequest, completion: completion)
    }
    
    func request(
        _ requestObject: NetworkRequestProtocol,
        completion: @escaping (Result<Void, NetworkError>) -> Void
    ) {
        let networkRequest = requestObject.asNetworkRequest()
        self.request(networkRequest, completion: completion)
    }
    
    // MARK: - Async/Await Support
    
    @available(iOS 13.0.0, *)
    func request<T: Decodable>(
        _ requestObject: NetworkRequestProtocol,
        responseType: T.Type,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        let networkRequest = requestObject.asNetworkRequest()
        return try await self.request(networkRequest, responseType: responseType, decoder: decoder)
    }
    
    @available(iOS 13.0.0, *)
    func request(_ requestObject: NetworkRequestProtocol) async throws -> Data {
        let networkRequest = requestObject.asNetworkRequest()
        return try await self.request(networkRequest)
    }
}

extension NetworkManager: URLSessionDelegate {
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
              let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.performDefaultHandling, nil)
            return
        }
        
        let domain = challenge.protectionSpace.host
        
        switch configuration.certificateValidation {
        case .default:
            // Validação padrão do sistema
            completionHandler(.performDefaultHandling, nil)
            
        case .disabled:
            // Desabilitar validação (apenas desenvolvimento)
            print("⚠️ ATENÇÃO: Validação de certificado DESABILITADA para \(domain)")
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
            
        case .pinned(let certificates):
            // SSL Pinning
            if validateServerTrust(serverTrust, pinnedCertificates: certificates, domain: domain) {
                print("✅ SSL Pinning validado para \(domain)")
                let credential = URLCredential(trust: serverTrust)
                completionHandler(.useCredential, credential)
            } else {
                print("❌ SSL Pinning FALHOU para \(domain)")
                completionHandler(.cancelAuthenticationChallenge, nil)
            }
            
        case .custom(let validator):
            // Validação customizada
            if validator.validate(trust: serverTrust, domain: domain) {
                print("✅ Validação customizada OK para \(domain)")
                let credential = URLCredential(trust: serverTrust)
                completionHandler(.useCredential, credential)
            } else {
                print("❌ Validação customizada FALHOU para \(domain)")
                completionHandler(.cancelAuthenticationChallenge, nil)
            }
        }
    }
    
    // MARK: - SSL Pinning Validation
    
    private func validateServerTrust(_ serverTrust: SecTrust, pinnedCertificates: [Data], domain: String) -> Bool {
        // Configurar políticas de avaliação
        let policy = SecPolicyCreateSSL(true, domain as CFString)
        SecTrustSetPolicies(serverTrust, policy)
        
        // Avaliar confiança
        var secTrustResultType = SecTrustResultType.invalid
        SecTrustEvaluate(serverTrust, &secTrustResultType)
        
        // Obter certificado do servidor
        guard let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) else {
            return false
        }
        
        let serverCertificateData = SecCertificateCopyData(serverCertificate) as Data
        
        // Comparar com certificados pinados
        return pinnedCertificates.contains(serverCertificateData)
    }
}
