//
//  NetworkManager.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

public final class NetworkManager: NSObject {
    
    // MARK: - Properties
    
    private lazy var session: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = configuration.timeoutInterval
        sessionConfig.timeoutIntervalForResource = configuration.timeoutInterval
        
        return URLSession(
            configuration: sessionConfig,
            delegate: self,
            delegateQueue: nil
        )
    }()

    let configuration: NetworkConfiguration
    private let requestBuilder: RequestBuilder
    private let logger: NetworkLogger?
    private let mockUtils: MockUtilsLogic
    private let jsonUtils: JSONUtilsLogic
    
    private var debugMode: Bool = Environment.current == .development
    
    // MARK: - Singleton (Opcional)
    
    public static private(set) var shared: NetworkManager?
    
    public static func configure(with configuration: NetworkConfiguration,
                                 logger: NetworkLogger? = DefaultNetworkLogger(),
                                 mockConfig: MockConfigurationProtocol) {
        guard shared == nil else {
            print("⚠️ NetworkManager já foi configurado. Ignorando nova configuração.")
            return
        }
        shared = NetworkManager(configuration: configuration, logger: logger, mockConfig: mockConfig)
    }
    
    public static func reconfigure(with configuration: NetworkConfiguration,
                                   logger: NetworkLogger? = nil,
                                   mockConfig: MockConfigurationProtocol) {
            shared = NetworkManager(configuration: configuration, logger: logger, mockConfig: mockConfig)
    }
    
    // MARK: - Initialization
    
    public init(configuration: NetworkConfiguration,
                logger: NetworkLogger? = nil,
                mockConfig: MockConfigurationProtocol,
                mockUtils: MockUtilsLogic = MockUtils(),
                jsonUtils: JSONUtilsLogic = JSONUtils()) {
        self.configuration = configuration
        self.requestBuilder = RequestBuilder(configuration: configuration)
        self.logger = logger
        self.mockUtils = mockUtils
        self.jsonUtils = jsonUtils
        mockUtils.configMockService(with: mockConfig)
        super.init()
    }
    
    // MARK: - Public Methods
    
    /// Executa uma requisição e retorna dados decodificados
    public func request<T: Decodable>(_ request: NetworkRequest, responseType: T.Type, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<NetworkResponse<T>, NetworkError>) -> Void) {
        executeRequest(request) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try decoder.decode(T.self, from: response.data)
                    let networkResponse = NetworkResponse(
                        data: decodedData,
                        statusCode: response.statusCode,
                        headers: response.headers
                    )
                    completion(.success(networkResponse))
                } catch {
                    self?.logger?.log(response: nil, data: response.data, error: error)
                    completion(.failure(.decodingError(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Executa uma requisição e retorna dados brutos
    public func request(_ request: NetworkRequest, completion: @escaping (Result<NetworkResponse<Data>, NetworkError>) -> Void) {
        executeRequest(request, completion: completion)
    }
    
    /// Executa uma requisição sem retorno de dados (ex: DELETE)
    public func request(_ request: NetworkRequest,completion: @escaping (Result<Void, NetworkError>) -> Void) {
        executeRequest(request) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Async/Await Support (iOS 13+)
    
    @available(iOS 13.0.0, *)
    public func request<T: Decodable>(_ request: NetworkRequest, responseType: T.Type, decoder: JSONDecoder = JSONDecoder()) async throws -> NetworkResponse<T> {
        return try await withCheckedThrowingContinuation { continuation in
            self.request(request, responseType: responseType, decoder: decoder) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    @available(iOS 13.0.0, *)
    public func request(_ request: NetworkRequest) async throws -> NetworkResponse<Data> {
        return try await withCheckedThrowingContinuation { continuation in
            self.request(request) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func executeRequest(_ request: NetworkRequest, completion: @escaping (Result<NetworkResponse<Data>, NetworkError>) -> Void) {
        let urlRequest: URLRequest
        
        do {
            urlRequest = try requestBuilder.build(from: request)
        } catch let error as NetworkError {
            completion(.failure(error))
            return
        } catch {
            completion(.failure(.encodingError(error)))
            return
        }
        
        logger?.log(request: urlRequest)
        
        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            self?.logger?.log(response: response, data: data, error: error)
            
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknown))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // Verificar status code
            switch httpResponse.statusCode {
            case 200...299:
                let networkResponse = NetworkResponse(
                    data: data,
                    statusCode: httpResponse.statusCode,
                    headers: httpResponse.allHeaderFields
                )
                completion(.success(networkResponse))
            case 401:
                completion(.failure(.unauthorized))
            case 400...499:
                completion(.failure(.httpError(statusCode: httpResponse.statusCode, data: data)))
            case 500...599:
                let errorMessage = String(data: data, encoding: .utf8) ?? "Erro desconhecido"
                completion(.failure(.serverError(errorMessage)))
            default:
                completion(.failure(.httpError(statusCode: httpResponse.statusCode, data: data)))
            }
        }
        
        task.resume()
    }
    
    func continueWithoutMock<T: Codable, E: Codable>(model: T.Type, request: NetworkRequestProtocol, customError: E.Type, completion: @escaping (Result<NetworkResponse<T>, NetworkError>) -> Void) -> Bool {
        guard debugMode,
              let response = checkExistantMock(request: request, model: model, customError: customError) else { return true }
        //if response.httpStatus.isHTTPSuccess, let successResponse = response.results {
        //    completion(.success(successResponse))
        //} else if let errorResponse = response.errorResults {
        //    completion(.failure(.customError(statusCode: response.httpStatus, result: errorResponse)))
        //} else {
        //    completion(.failure(.mappingError))
        //}
        return false
    }
    
    private func checkExistantMock<T: Codable, E: Codable>(request: NetworkRequestProtocol, model: T.Type, customError: E.Type) -> MockResponse<T, E>? {
        guard let data = mockUtils.checkExistantMock(request: request) else { return nil }
        return jsonUtils.convertMock(jsonData: data, to: model, customError: customError)
    }
}

