# 🎯 Guia Prático de Uso da Estrutura

## 🚀 Quick Start

### 1. Criando Nova Feature

#### Passo a Passo:

```bash
# 1. Crie a estrutura de pastas
Features/
└── MinhaFeature/
    ├── Models/
    ├── ViewModels/
    ├── Views/
    ├── Services/
    └── Components/
```

#### 2. Crie os arquivos na ordem:

##### a) Model (Domain)
```swift
// Features/MinhaFeature/Models/Item.swift
struct Item: Identifiable, Codable {
    let id: String
    var name: String
    var description: String
}
```

##### b) Service (Data Layer)
```swift
// Features/MinhaFeature/Services/ItemService.swift
protocol ItemServiceProtocol: Sendable {
    func fetchItems() async throws -> [Item]
}

final class ItemService: ItemServiceProtocol, @unchecked Sendable {
    func fetchItems() async throws -> [Item] {
        // API call
    }
}
```

##### c) ViewModel (Logic)
```swift
// Features/MinhaFeature/ViewModels/ItemViewModel.swift
@MainActor
class ItemViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var isLoading = false
    
    private let service: ItemServiceProtocol
    
    nonisolated init(service: ItemServiceProtocol = ItemService()) {
        self.service = service
    }
    
    func fetchItems() async {
        isLoading = true
        do {
            items = try await service.fetchItems()
        } catch {
            // Handle error
        }
        isLoading = false
    }
}
```

##### d) View (UI)
```swift
// Features/MinhaFeature/Views/ItemListView.swift
struct ItemListView: View {
    @StateObject private var viewModel = ItemViewModel()
    
    var body: some View {
        List(viewModel.items) { item in
            Text(item.name)
        }
        .task {
            await viewModel.fetchItems()
        }
    }
}
```

---

## 🎨 Criando Componentes Compartilhados

### Quando criar um componente compartilhado?

✅ **SIM** - Quando o componente é usado em 2+ features  
✅ **SIM** - Quando faz parte do design system  
❌ **NÃO** - Quando é específico de uma feature

### Exemplo:

```swift
// DesignSystem/Components/Buttons/PrimaryButton.swift
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
        }
    }
}

// Uso em qualquer feature:
PrimaryButton(title: "Salvar") {
    // Ação
}
```

---

## 🔧 Adicionando Nova Extension

### Extensions vão em Utilities/Extensions/

```swift
// Utilities/Extensions/String+Extensions.swift
extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

// Uso:
let email = "test@example.com"
if email.isValidEmail {
    print("Valid!")
}
```

---

## 🌐 Configurando Networking

### 1. Crie o Network Manager em Core/Network/

```swift
// Core/Network/NetworkManager.swift
final class NetworkManager: @unchecked Sendable {
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.exemplo.com"
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        self.session = URLSession(configuration: config)
    }
    
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        body: Encodable? = nil
    ) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case invalidURL
    case serverError
    case decodingError
}
```

### 2. Use nos Services:

```swift
final class ProductService: ProductServiceProtocol {
    private let network = NetworkManager.shared
    
    func fetchProducts() async throws -> [Product] {
        try await network.request(endpoint: "/products")
    }
}
```

---

## 💾 Configurando Storage Local

### UserDefaults Manager

```swift
// Core/Storage/UserDefaultsManager.swift
final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    // Keys
    private enum Keys {
        static let userId = "userId"
        static let isLoggedIn = "isLoggedIn"
        static let theme = "theme"
    }
    
    // Properties
    var userId: String? {
        get { defaults.string(forKey: Keys.userId) }
        set { defaults.set(newValue, forKey: Keys.userId) }
    }
    
    var isLoggedIn: Bool {
        get { defaults.bool(forKey: Keys.isLoggedIn) }
        set { defaults.set(newValue, forKey: Keys.isLoggedIn) }
    }
    
    func clear() {
        if let bundleID = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: bundleID)
        }
    }
}
```

---

## 🧪 Criando Testes

### Estrutura de Teste:

```swift
// Tests/UnitTests/ViewModelTests/ItemViewModelTests.swift
import XCTest
@testable import YourApp

@MainActor
final class ItemViewModelTests: XCTestCase {
    var sut: ItemViewModel!
    var mockService: MockItemService!
    
    override func setUp() {
        super.setUp()
        mockService = MockItemService()
        sut = ItemViewModel(service: mockService)
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchItemsSuccess() async {
        // Given
        let expectedItems = [Item(id: "1", name: "Test", description: "Desc")]
        mockService.items = expectedItems
        
        // When
        await sut.fetchItems()
        
        // Then
        XCTAssertEqual(sut.items.count, 1)
        XCTAssertEqual(sut.items.first?.name, "Test")
        XCTAssertFalse(sut.isLoading)
    }
}

// Tests/Mocks/MockServices/MockItemService.swift
final class MockItemService: ItemServiceProtocol {
    var items: [Item] = []
    var shouldThrowError = false
    
    func fetchItems() async throws -> [Item] {
        if shouldThrowError {
            throw NetworkError.serverError
        }
        return items
    }
}
```

---

## 🎭 Implementando Temas

### 1. Configure Colors no Assets.xcassets

```
Assets.xcassets/
└── Colors/
    ├── Primary.colorset/
    ├── Secondary.colorset/
    ├── Background.colorset/
    └── TextPrimary.colorset/
```

### 2. Use o Theme Manager:

```swift
// Em qualquer View:
struct MyView: View {
    @Environment(\.theme) var themeManager
    
    var theme: AppTheme {
        themeManager.currentTheme
    }
    
    var body: some View {
        Text("Hello")
            .foregroundColor(theme.colors.textPrimary)
            .padding(theme.spacing.md)
            .background(theme.colors.background)
    }
}
```

---

## 📱 Navegação com Router

### Setup no App:

```swift
@main
struct YourApp: App {
    @StateObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.router, router)
        }
    }
}
```

### Uso nas Views:

```swift
struct HomeView: View {
    @Environment(\.router) var router
    
    var body: some View {
        VStack {
            Button("Ver Perfil") {
                router.navigate(to: .profile)
            }
            
            Button("Ver Produto") {
                router.presentSheet(.productDetail(id: "123"))
            }
        }
    }
}
```

---

## 🔐 Keychain para Tokens

```swift
// Core/Storage/KeychainManager.swift
final class KeychainManager {
    static let shared = KeychainManager()
    
    private init() {}
    
    func save(_ data: Data, for key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }
    
    func get(for key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }
    
    func delete(for key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
}

// Uso:
extension KeychainManager {
    var authToken: String? {
        get {
            guard let data = get(for: "authToken") else { return nil }
            return String(data: data, encoding: .utf8)
        }
        set {
            if let token = newValue, let data = token.data(using: .utf8) {
                _ = save(data, for: "authToken")
            } else {
                _ = delete(for: "authToken")
            }
        }
    }
}
```

---

## ✅ Checklist para Nova Feature

```
□ Criar estrutura de pastas
□ Criar Models
□ Criar Service com Protocol
□ Criar ViewModel com @MainActor
□ Criar Views principais
□ Criar Components se necessário
□ Adicionar testes unitários
□ Adicionar README.md na feature
□ Registrar no Router (se usar navegação)
□ Code Review
□ Merge to main
```

---

## 🎓 Dicas Finais

1. **Sempre comece pelo Model** - Define a estrutura de dados
2. **Service vem antes do ViewModel** - Lógica de dados separada
3. **ViewModel não conhece Views** - Apenas publica dados
4. **Views são burras** - Só renderizam dados do ViewModel
5. **Componentes reutilizáveis** - Se usa 2x, vai para DesignSystem
6. **Teste seus ViewModels** - Testes unitários são essenciais
7. **Use DI** - Facilita testes e manutenção
8. **Documente** - README em cada feature

---

Esta estrutura escala de MVP até apps enterprise! 🚀