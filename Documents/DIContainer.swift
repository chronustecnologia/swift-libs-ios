// MARK: - DIContainer.swift
// Dependency Injection Container

import Foundation

// MARK: - DI Container Protocol
protocol DIContainerProtocol {
    func register<T>(_ type: T.Type, factory: @escaping () -> T)
    func resolve<T>(_ type: T.Type) -> T
}

// MARK: - DI Container
final class DIContainer: DIContainerProtocol {
    
    // MARK: - Singleton
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: - Storage
    private var factories: [String: Any] = [:]
    private var singletons: [String: Any] = [:]
    
    // MARK: - Register
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        factories[key] = factory
    }
    
    func registerSingleton<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        factories[key] = factory
        singletons[key] = factory()
    }
    
    // MARK: - Resolve
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        
        // Check singletons first
        if let singleton = singletons[key] as? T {
            return singleton
        }
        
        // Create new instance
        guard let factory = factories[key] as? () -> T else {
            fatalError("No factory registered for type \(type)")
        }
        
        return factory()
    }
}

// MARK: - Property Wrapper for Injection
@propertyWrapper
struct Injected<T> {
    private let container: DIContainerProtocol
    
    var wrappedValue: T {
        container.resolve(T.self)
    }
    
    init(container: DIContainerProtocol = DIContainer.shared) {
        self.container = container
    }
}

// MARK: - Service Registration
extension DIContainer {
    
    static func registerAllServices() {
        let container = DIContainer.shared
        
        // Register Services
        container.registerSingleton(NetworkManagerProtocol.self) {
            NetworkManager()
        }
        
        container.register(UserServiceProtocol.self) {
            UserService()
        }
        
        container.register(AuthenticationServiceProtocol.self) {
            AuthenticationService()
        }
        
        container.register(ProductServiceProtocol.self) {
            ProductService()
        }
        
        // Register ViewModels (if needed)
        // ViewModels geralmente não são registrados no container
        // pois são criados pelas Views
    }
}

// MARK: - Example Services

protocol NetworkManagerProtocol {
    func request(_ endpoint: String) async throws -> Data
}

class NetworkManager: NetworkManagerProtocol {
    func request(_ endpoint: String) async throws -> Data {
        // Implementation
        Data()
    }
}

protocol UserServiceProtocol {
    func fetchUser(id: String) async throws -> String
}

class UserService: UserServiceProtocol {
    @Injected var networkManager: NetworkManagerProtocol
    
    func fetchUser(id: String) async throws -> String {
        // Use networkManager
        return "User"
    }
}

protocol AuthenticationServiceProtocol {
    func login(email: String, password: String) async throws -> Bool
}

class AuthenticationService: AuthenticationServiceProtocol {
    @Injected var networkManager: NetworkManagerProtocol
    
    func login(email: String, password: String) async throws -> Bool {
        // Implementation
        return true
    }
}

protocol ProductServiceProtocol {
    func fetchProducts() async throws -> [String]
}

class ProductService: ProductServiceProtocol {
    @Injected var networkManager: NetworkManagerProtocol
    
    func fetchProducts() async throws -> [String] {
        // Implementation
        return []
    }
}

// MARK: - Usage Example

// 1. No AppDelegate ou App init:
// DIContainer.registerAllServices()

// 2. Em ViewModels:
@MainActor
class LoginViewModel: ObservableObject {
    @Injected var authService: AuthenticationServiceProtocol
    
    func login(email: String, password: String) async {
        do {
            let success = try await authService.login(email: email, password: password)
            // Handle success
        } catch {
            // Handle error
        }
    }
}

// 3. Em Services:
class ProfileService {
    @Injected var userService: UserServiceProtocol
    @Injected var networkManager: NetworkManagerProtocol
    
    func fetchProfile() async throws -> String {
        return try await userService.fetchUser(id: "123")
    }
}