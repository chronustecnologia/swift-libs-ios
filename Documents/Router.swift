// MARK: - Router.swift
// Exemplo de implementação de roteamento centralizado

import SwiftUI

// MARK: - Route Enum
enum Route: Hashable {
    // Authentication
    case login
    case register
    case forgotPassword
    
    // Home
    case home
    case homeDetail(id: String)
    
    // Profile
    case profile
    case editProfile
    
    // Products
    case productList
    case productDetail(id: String)
    
    // Settings
    case settings
    case notifications
}

// MARK: - Router
@MainActor
class Router: ObservableObject {
    
    // MARK: - Properties
    @Published var path = NavigationPath()
    @Published var presentedSheet: Route?
    @Published var presentedFullScreen: Route?
    
    // MARK: - Navigation Methods
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
    
    func presentSheet(_ route: Route) {
        presentedSheet = route
    }
    
    func presentFullScreen(_ route: Route) {
        presentedFullScreen = route
    }
    
    func dismissSheet() {
        presentedSheet = nil
    }
    
    func dismissFullScreen() {
        presentedFullScreen = nil
    }
    
    // MARK: - View Builder
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        // Authentication
        case .login:
            Text("LoginView") // LoginView()
        case .register:
            Text("RegisterView") // RegisterView()
        case .forgotPassword:
            Text("ForgotPasswordView") // ForgotPasswordView()
            
        // Home
        case .home:
            Text("HomeView") // HomeView()
        case .homeDetail(let id):
            Text("HomeDetailView - \(id)") // HomeDetailView(id: id)
            
        // Profile
        case .profile:
            Text("ProfileView") // ProfileView()
        case .editProfile:
            Text("EditProfileView") // EditProfileView()
            
        // Products
        case .productList:
            Text("ProductListView") // ProductListView()
        case .productDetail(let id):
            Text("ProductDetailView - \(id)") // ProductDetailView(id: id)
            
        // Settings
        case .settings:
            Text("SettingsView") // SettingsView()
        case .notifications:
            Text("NotificationSettingsView") // NotificationSettingsView()
        }
    }
}

// MARK: - Router Environment Key
struct RouterKey: EnvironmentKey {
    static let defaultValue = Router()
}

extension EnvironmentValues {
    var router: Router {
        get { self[RouterKey.self] }
        set { self[RouterKey.self] = newValue }
    }
}

// MARK: - Usage Example
struct RootView: View {
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            router.view(for: .home)
                .navigationDestination(for: Route.self) { route in
                    router.view(for: route)
                }
        }
        .sheet(item: $router.presentedSheet) { route in
            router.view(for: route)
        }
        .fullScreenCover(item: $router.presentedFullScreen) { route in
            router.view(for: route)
        }
        .environment(\.router, router)
    }
}

// MARK: - Usage in Views
struct ExampleUsageView: View {
    @Environment(\.router) var router
    
    var body: some View {
        VStack {
            Button("Go to Profile") {
                router.navigate(to: .profile)
            }
            
            Button("Show Product Detail") {
                router.presentSheet(.productDetail(id: "123"))
            }
        }
    }
}