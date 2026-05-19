# 📁 Estrutura de Pastas - SwiftUI App Escalável

## 🏗️ Estrutura Completa

```
YourApp/
├── 📱 App/
│   ├── YourAppApp.swift              # Entry point do app
│   ├── AppDelegate.swift             # App lifecycle (se necessário)
│   └── SceneDelegate.swift           # Scene lifecycle (se necessário)
│
├── 🎯 Features/                       # FUNCIONALIDADES (cada feature isolada)
│   │
│   ├── Authentication/
│   │   ├── Models/
│   │   │   ├── User.swift
│   │   │   └── LoginCredentials.swift
│   │   ├── ViewModels/
│   │   │   ├── LoginViewModel.swift
│   │   │   └── RegisterViewModel.swift
│   │   ├── Views/
│   │   │   ├── LoginView.swift
│   │   │   ├── RegisterView.swift
│   │   │   └── ForgotPasswordView.swift
│   │   ├── Services/
│   │   │   └── AuthenticationService.swift
│   │   └── Components/
│   │       ├── AuthTextField.swift
│   │       └── SocialLoginButton.swift
│   │
│   ├── Home/
│   │   ├── Models/
│   │   │   └── HomeData.swift
│   │   ├── ViewModels/
│   │   │   └── HomeViewModel.swift
│   │   ├── Views/
│   │   │   ├── HomeView.swift
│   │   │   └── HomeDetailView.swift
│   │   ├── Services/
│   │   │   └── HomeService.swift
│   │   └── Components/
│   │       ├── HomeCardView.swift
│   │       └── HomeBannerView.swift
│   │
│   ├── Profile/
│   │   ├── Models/
│   │   │   └── Profile.swift
│   │   ├── ViewModels/
│   │   │   └── ProfileViewModel.swift
│   │   ├── Views/
│   │   │   ├── ProfileView.swift
│   │   │   └── EditProfileView.swift
│   │   ├── Services/
│   │   │   └── ProfileService.swift
│   │   └── Components/
│   │       └── ProfileHeaderView.swift
│   │
│   ├── Products/
│   │   ├── Models/
│   │   │   ├── Product.swift
│   │   │   └── Category.swift
│   │   ├── ViewModels/
│   │   │   ├── ProductListViewModel.swift
│   │   │   └── ProductDetailViewModel.swift
│   │   ├── Views/
│   │   │   ├── ProductListView.swift
│   │   │   ├── ProductDetailView.swift
│   │   │   └── ProductFilterView.swift
│   │   ├── Services/
│   │   │   └── ProductService.swift
│   │   └── Components/
│   │       ├── ProductCardView.swift
│   │       └── ProductRatingView.swift
│   │
│   └── Settings/
│       ├── Models/
│       │   └── SettingsOption.swift
│       ├── ViewModels/
│       │   └── SettingsViewModel.swift
│       ├── Views/
│       │   ├── SettingsView.swift
│       │   └── NotificationSettingsView.swift
│       └── Services/
│           └── SettingsService.swift
│
├── 🔧 Core/                          # FUNCIONALIDADES CORE DO APP
│   │
│   ├── Navigation/
│   │   ├── Router.swift              # Coordenador de navegação
│   │   ├── Route.swift               # Definição de rotas
│   │   └── NavigationCoordinator.swift
│   │
│   ├── Network/
│   │   ├── NetworkManager.swift      # Gerenciador de rede
│   │   ├── APIEndpoint.swift         # Endpoints da API
│   │   ├── NetworkError.swift        # Erros de rede
│   │   ├── APIClient.swift           # Cliente HTTP
│   │   └── RequestBuilder.swift      # Construtor de requests
│   │
│   ├── Storage/
│   │   ├── UserDefaultsManager.swift
│   │   ├── KeychainManager.swift     # Senhas e tokens
│   │   ├── CoreDataManager.swift     # Persistência local
│   │   └── FileManager+Extensions.swift
│   │
│   ├── Security/
│   │   ├── BiometricAuth.swift
│   │   ├── TokenManager.swift
│   │   └── EncryptionManager.swift
│   │
│   └── Analytics/
│       ├── AnalyticsManager.swift
│       ├── AnalyticsEvent.swift
│       └── TrackingProtocol.swift
│
├── 🎨 DesignSystem/                  # DESIGN SYSTEM COMPARTILHADO
│   │
│   ├── Theme/
│   │   ├── Colors.swift              # Paleta de cores
│   │   ├── Typography.swift          # Tipografia
│   │   ├── Spacing.swift             # Espaçamentos
│   │   ├── Shadows.swift             # Sombras
│   │   └── Theme.swift               # Tema geral
│   │
│   ├── Components/                   # Componentes reutilizáveis
│   │   ├── Buttons/
│   │   │   ├── PrimaryButton.swift
│   │   │   ├── SecondaryButton.swift
│   │   │   └── IconButton.swift
│   │   ├── TextFields/
│   │   │   ├── CustomTextField.swift
│   │   │   └── SearchTextField.swift
│   │   ├── Cards/
│   │   │   ├── BaseCard.swift
│   │   │   └── ImageCard.swift
│   │   ├── LoadingViews/
│   │   │   ├── LoadingView.swift
│   │   │   ├── SkeletonView.swift
│   │   │   └── ShimmerView.swift
│   │   ├── EmptyStates/
│   │   │   ├── EmptyStateView.swift
│   │   │   └── ErrorStateView.swift
│   │   └── NavigationBar/
│   │       └── CustomNavigationBar.swift
│   │
│   ├── Modifiers/                    # View Modifiers customizados
│   │   ├── CardModifier.swift
│   │   ├── ShadowModifier.swift
│   │   └── ShimmerModifier.swift
│   │
│   └── Icons/
│       └── AppIcons.swift            # Ícones do app
│
├── 🛠️ Utilities/                     # UTILITÁRIOS GERAIS
│   │
│   ├── Extensions/
│   │   ├── View+Extensions.swift
│   │   ├── String+Extensions.swift
│   │   ├── Date+Extensions.swift
│   │   ├── Color+Extensions.swift
│   │   ├── Array+Extensions.swift
│   │   └── Int+Extensions.swift
│   │
│   ├── Helpers/
│   │   ├── Logger.swift              # Sistema de logs
│   │   ├── Validator.swift           # Validações (email, CPF, etc)
│   │   ├── Formatter.swift           # Formatadores (data, moeda, etc)
│   │   ├── ImagePicker.swift         # Picker de imagens
│   │   └── HapticManager.swift       # Feedback háptico
│   │
│   ├── Protocols/
│   │   ├── Loadable.swift
│   │   ├── ErrorHandling.swift
│   │   └── Configurable.swift
│   │
│   └── Constants/
│       ├── AppConstants.swift        # Constantes gerais
│       ├── APIConstants.swift        # URLs, keys, etc
│       └── LocalizationKeys.swift    # Chaves de tradução
│
├── 📦 Models/                        # MODELS COMPARTILHADOS (GLOBAL)
│   ├── Common/
│   │   ├── APIResponse.swift
│   │   ├── PaginatedResponse.swift
│   │   └── ErrorResponse.swift
│   └── DTOs/
│       └── UserDTO.swift
│
├── 🔌 Services/                      # SERVIÇOS COMPARTILHADOS
│   ├── LocationService.swift
│   ├── NotificationService.swift
│   ├── ImageCacheService.swift
│   └── DeepLinkService.swift
│
├── 🌍 Localization/                  # INTERNACIONALIZAÇÃO
│   ├── en.lproj/
│   │   └── Localizable.strings
│   ├── pt-BR.lproj/
│   │   └── Localizable.strings
│   └── LocalizationManager.swift
│
├── 📱 Resources/                     # RECURSOS
│   ├── Assets.xcassets/              # Imagens, cores, etc
│   ├── Fonts/                        # Fontes customizadas
│   ├── Videos/
│   └── Sounds/
│
├── 🧪 Tests/                         # TESTES
│   ├── UnitTests/
│   │   ├── ViewModelTests/
│   │   │   ├── LoginViewModelTests.swift
│   │   │   └── ProductListViewModelTests.swift
│   │   ├── ServiceTests/
│   │   │   └── AuthenticationServiceTests.swift
│   │   └── UtilityTests/
│   │       └── ValidatorTests.swift
│   │
│   ├── IntegrationTests/
│   │   └── APIIntegrationTests.swift
│   │
│   ├── UITests/
│   │   ├── LoginFlowUITests.swift
│   │   └── ProductFlowUITests.swift
│   │
│   └── Mocks/
│       ├── MockServices/
│       │   └── MockAuthenticationService.swift
│       └── MockData/
│           └── MockUsers.swift
│
├── 🎯 DependencyInjection/           # INJEÇÃO DE DEPENDÊNCIAS
│   ├── DIContainer.swift
│   ├── ServiceRegistry.swift
│   └── EnvironmentKeys.swift
│
├── ⚙️ Configuration/                  # CONFIGURAÇÕES
│   ├── Development.xcconfig
│   ├── Staging.xcconfig
│   ├── Production.xcconfig
│   └── Environment.swift
│
└── 📄 Documentation/                 # DOCUMENTAÇÃO
    ├── Architecture.md
    ├── CodingGuidelines.md
    └── APIDocumentation.md
```

---

## 📋 Regras de Organização

### ✅ DO's (Faça)

1. **Feature-First**: Cada funcionalidade tem sua própria pasta
2. **MVVM Inside**: Dentro de cada feature, mantenha MVVM
3. **Shared Components**: Componentes genéricos em `DesignSystem/`
4. **Single Responsibility**: Uma classe, uma responsabilidade
5. **Clear Naming**: Nomes descritivos e consistentes

### ❌ DON'Ts (Não Faça)

1. **Não misture features**: Profile não vai dentro de Authentication
2. **Não duplique componentes**: Se é usado em 2+ features, vai para DesignSystem
3. **Não crie pastas vazias**: Crie conforme necessário
4. **Não coloque tudo em Services/**: Separe por feature
5. **Não ignore testes**: Cresça a pasta Tests junto com Features

---

## 🎯 Decisões de Onde Colocar o Código

### Quando criar nova Feature?
```
✅ SIM - Nova funcionalidade de negócio
✅ SIM - Grupo de telas relacionadas
❌ NÃO - Apenas 1 view simples (coloque em outra feature)
❌ NÃO - Componente reutilizável (vai para DesignSystem)
```

### Quando colocar em DesignSystem?
```
✅ SIM - Usado em 2+ features
✅ SIM - Parte do design system
✅ SIM - Componente genérico (Button, Card, etc)
❌ NÃO - Específico de uma feature
```

### Quando colocar em Core?
```
✅ SIM - Funcionalidade essencial do app
✅ SIM - Network, Storage, Navigation
✅ SIM - Usado em múltiplas features
❌ NÃO - Lógica de negócio específica
```

### Quando colocar em Utilities?
```
✅ SIM - Extensions gerais
✅ SIM - Helpers e formatters
✅ SIM - Validadores
❌ NÃO - Lógica de negócio
```

---

## 🚀 Começando do Zero

### Fase 1: Estrutura Mínima
```
YourApp/
├── App/
├── Features/
│   └── Authentication/
├── DesignSystem/
├── Core/
│   └── Network/
└── Utilities/
```

### Fase 2: Crescendo
```
+ Features/Home/
+ Features/Profile/
+ DesignSystem/Components/
+ Core/Storage/
```

### Fase 3: App Maduro
```
+ Features/Products/
+ Features/Orders/
+ Features/Payments/
+ DependencyInjection/
+ Tests/
```

---

## 💡 Exemplos Práticos

### Exemplo 1: Adicionar nova feature "Cart"
```
Features/
└── Cart/
    ├── Models/
    │   ├── CartItem.swift
    │   └── Cart.swift
    ├── ViewModels/
    │   └── CartViewModel.swift
    ├── Views/
    │   ├── CartView.swift
    │   └── CheckoutView.swift
    ├── Services/
    │   └── CartService.swift
    └── Components/
        └── CartItemRow.swift
```

### Exemplo 2: Criar componente compartilhado
```
DesignSystem/
└── Components/
    └── Badges/
        ├── Badge.swift
        ├── CountBadge.swift
        └── StatusBadge.swift
```

### Exemplo 3: Adicionar novo serviço global
```
Services/
└── PushNotificationService.swift
```

---

## 🎨 Nomenclatura

### Arquivos
```swift
// Views
LoginView.swift          ✅
login_view.swift         ❌

// ViewModels
LoginViewModel.swift     ✅
LoginVM.swift            ❌

// Services
AuthenticationService.swift  ✅
AuthService.swift            ⚠️ (ok, mas menos claro)

// Models
User.swift               ✅
UserModel.swift          ⚠️ (redundante, mas aceito)
```

### Pastas
```
Authentication/          ✅
Auth/                    ⚠️ (ok para abreviar)
authentication/          ❌ (use PascalCase)
```

---

## 🔍 Quando Refatorar?

### Sinais de que precisa reorganizar:

1. ❌ Arquivo com mais de 500 linhas
2. ❌ Pasta com mais de 15 arquivos
3. ❌ Componente usado em 3+ lugares e não está em DesignSystem
4. ❌ Service que serve múltiplas features e não está em Core
5. ❌ Extension específica dentro de Feature (mova para Utilities)

---

## 📱 Benefícios desta Estrutura

### ✅ Para Desenvolvedores
- Encontra código rapidamente
- Sabe onde colocar código novo
- Facilita code review
- Permite trabalho paralelo

### ✅ Para o Projeto
- Escala facilmente
- Facilita testes
- Reduz conflitos de merge
- Melhora manutenibilidade

### ✅ Para Novos Membros
- Onboarding mais rápido
- Padrão claro
- Documentação pela estrutura
- Menos dúvidas

---

## 🎓 Boas Práticas

1. **README em cada Feature**: Explique o que a feature faz
2. **Group no Xcode**: Mantenha grupos iguais à estrutura de pastas
3. **Prefixos claros**: Use prefixos como `Base`, `Custom`, `App`
4. **Versionamento**: Documente mudanças grandes na estrutura
5. **Consistência**: Siga sempre o mesmo padrão

---

## 🚦 Checklist para Nova Feature

```
□ Criar pasta Features/NomeDaFeature/
□ Adicionar subpastas: Models, ViewModels, Views, Services
□ Criar Models necessários
□ Criar Services com Protocol
□ Criar ViewModels com @MainActor
□ Criar Views
□ Adicionar testes em Tests/UnitTests/
□ Documentar no README da feature
□ Code review
```

---

Esta estrutura suporta apps de qualquer tamanho, de MVP até apps enterprise! 🚀