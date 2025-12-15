//
//  NetworkLogger.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

public protocol NetworkLogger {
    func log(request: URLRequest)
    func log(response: URLResponse?, data: Data?, error: Error?)
}

public class DefaultNetworkLogger: NetworkLogger {
    
    private let isEnabled: Bool
    
    public init(isEnabled: Bool = true) {
        self.isEnabled = isEnabled
    }
    
    public func log(request: URLRequest) {
        guard isEnabled else { return }
        
        print("🌐 ========== REQUEST ==========")
        print("URL: \(request.url?.absoluteString ?? "N/A")")
        print("Method: \(request.httpMethod ?? "N/A")")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        print("================================")
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        }
        print("===============================\n")
    }
    
    public func log(response: URLResponse?, data: Data?, error: Error?) {
        guard isEnabled else { return }
        
        print("📡 ========== RESPONSE ==========")
        
        if let httpResponse = response as? HTTPURLResponse {
            print("URL: \(httpResponse.url?.absoluteString ?? "")")
            print("Status Code: \(httpResponse.statusCode)")
            print("Headers: \(httpResponse.allHeaderFields)")
        }
        
        print("================================")
        
        if let data = data,
           let jsonString = String(data: data, encoding: .utf8) {
            print("Data: \(jsonString)")
        }
        
        if let error = error {
            print("❌ Error: \(error.localizedDescription)")
        }
        
        print("================================\n")
    }
}
