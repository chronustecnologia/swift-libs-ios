#!/bin/bash

# 🚀 Script para criar estrutura de pastas SwiftUI
# Uso: ./create_structure.sh NomeDoProjeto

PROJECT_NAME=${1:-MyApp}

echo "📦 Criando estrutura de pastas para $PROJECT_NAME..."

# App
mkdir -p "$PROJECT_NAME/App"

# Features
mkdir -p "$PROJECT_NAME/Features/Authentication/Models"
mkdir -p "$PROJECT_NAME/Features/Authentication/ViewModels"
mkdir -p "$PROJECT_NAME/Features/Authentication/Views"
mkdir -p "$PROJECT_NAME/Features/Authentication/Services"
mkdir -p "$PROJECT_NAME/Features/Authentication/Components"

mkdir -p "$PROJECT_NAME/Features/Home/Models"
mkdir -p "$PROJECT_NAME/Features/Home/ViewModels"
mkdir -p "$PROJECT_NAME/Features/Home/Views"
mkdir -p "$PROJECT_NAME/Features/Home/Services"
mkdir -p "$PROJECT_NAME/Features/Home/Components"

mkdir -p "$PROJECT_NAME/Features/Profile/Models"
mkdir -p "$PROJECT_NAME/Features/Profile/ViewModels"
mkdir -p "$PROJECT_NAME/Features/Profile/Views"
mkdir -p "$PROJECT_NAME/Features/Profile/Services"
mkdir -p "$PROJECT_NAME/Features/Profile/Components"

# Core
mkdir -p "$PROJECT_NAME/Core/Navigation"
mkdir -p "$PROJECT_NAME/Core/Network"
mkdir -p "$PROJECT_NAME/Core/Storage"
mkdir -p "$PROJECT_NAME/Core/Security"
mkdir -p "$PROJECT_NAME/Core/Analytics"

# Design System
mkdir -p "$PROJECT_NAME/DesignSystem/Theme"
mkdir -p "$PROJECT_NAME/DesignSystem/Components/Buttons"
mkdir -p "$PROJECT_NAME/DesignSystem/Components/TextFields"
mkdir -p "$PROJECT_NAME/DesignSystem/Components/Cards"
mkdir -p "$PROJECT_NAME/DesignSystem/Components/LoadingViews"
mkdir -p "$PROJECT_NAME/DesignSystem/Components/EmptyStates"
mkdir -p "$PROJECT_NAME/DesignSystem/Modifiers"
mkdir -p "$PROJECT_NAME/DesignSystem/Icons"

# Utilities
mkdir -p "$PROJECT_NAME/Utilities/Extensions"
mkdir -p "$PROJECT_NAME/Utilities/Helpers"
mkdir -p "$PROJECT_NAME/Utilities/Protocols"
mkdir -p "$PROJECT_NAME/Utilities/Constants"

# Models
mkdir -p "$PROJECT_NAME/Models/Common"
mkdir -p "$PROJECT_NAME/Models/DTOs"

# Services
mkdir -p "$PROJECT_NAME/Services"

# Localization
mkdir -p "$PROJECT_NAME/Localization/en.lproj"
mkdir -p "$PROJECT_NAME/Localization/pt-BR.lproj"

# Resources
mkdir -p "$PROJECT_NAME/Resources/Assets.xcassets"
mkdir -p "$PROJECT_NAME/Resources/Fonts"

# Tests
mkdir -p "$PROJECT_NAME/Tests/UnitTests/ViewModelTests"
mkdir -p "$PROJECT_NAME/Tests/UnitTests/ServiceTests"
mkdir -p "$PROJECT_NAME/Tests/UnitTests/UtilityTests"
mkdir -p "$PROJECT_NAME/Tests/IntegrationTests"
mkdir -p "$PROJECT_NAME/Tests/UITests"
mkdir -p "$PROJECT_NAME/Tests/Mocks/MockServices"
mkdir -p "$PROJECT_NAME/Tests/Mocks/MockData"

# Dependency Injection
mkdir -p "$PROJECT_NAME/DependencyInjection"

# Configuration
mkdir -p "$PROJECT_NAME/Configuration"

# Documentation
mkdir -p "$PROJECT_NAME/Documentation"

# Criar arquivos README em cada feature
cat > "$PROJECT_NAME/Features/Authentication/README.md" << 'EOF'
# Authentication Feature

Funcionalidade responsável por autenticação de usuários.

## Telas
- LoginView
- RegisterView
- ForgotPasswordView

## Fluxos
1. Login com email/senha
2. Login social (Google, Apple)
3. Registro de novo usuário
4. Recuperação de senha
EOF

cat > "$PROJECT_NAME/Features/Home/README.md" << 'EOF'
# Home Feature

Tela principal do aplicativo após login.

## Telas
- HomeView
- HomeDetailView

## Componentes
- HomeCardView
- HomeBannerView
EOF

cat > "$PROJECT_NAME/Features/Profile/README.md" << 'EOF'
# Profile Feature

Funcionalidade de perfil do usuário.

## Telas
- ProfileView
- EditProfileView

## Fluxos
1. Visualizar perfil
2. Editar informações
3. Alterar foto
4. Configurações de conta
EOF

# Criar arquivo principal de documentação
cat > "$PROJECT_NAME/Documentation/Architecture.md" << 'EOF'
# Arquitetura do Projeto

## MVVM + Feature-First

Este projeto utiliza arquitetura MVVM (Model-View-ViewModel) organizada por features.

### Camadas

- **Model**: Dados e lógica de negócio
- **View**: Interface do usuário (SwiftUI)
- **ViewModel**: Lógica de apresentação

### Organização

Cada funcionalidade possui sua própria pasta contendo:
- Models
- ViewModels
- Views
- Services
- Components

### Fluxo de Dados

View → ViewModel → Service → API → Service → ViewModel → View
EOF

# Criar .gitignore
cat > "$PROJECT_NAME/.gitignore" << 'EOF'
# Xcode
*.xcodeproj/*
!*.xcodeproj/project.pbxproj
!*.xcworkspace/contents.xcworkspacedata
*.xccheckout
*.moved-aside
*.xcuserstate
*.xcscmblueprint

# Swift Package Manager
.swiftpm/
.build/
Packages/

# CocoaPods
Pods/
*.podspec

# Carthage
Carthage/Build/

# Fastlane
fastlane/report.xml
fastlane/Preview.html
fastlane/screenshots/**/*.png
fastlane/test_output

# macOS
.DS_Store
.AppleDouble
.LSOverride

# Build
DerivedData/
build/
*.ipa
*.dSYM.zip
*.dSYM
EOF

echo "✅ Estrutura criada com sucesso!"
echo ""
echo "📁 Estrutura criada em: $PROJECT_NAME/"
echo ""
echo "🎯 Próximos passos:"
echo "1. cd $PROJECT_NAME"
echo "2. Abrir no Xcode e adicionar grupos correspondentes"
echo "3. Começar a desenvolver suas features!"
echo ""
echo "📖 Documentação: $PROJECT_NAME/Documentation/Architecture.md"