// MARK: - Theme.swift
// Sistema de Design centralizado

import SwiftUI

// MARK: - App Theme
struct AppTheme {
    let colors: ColorPalette
    let typography: Typography
    let spacing: Spacing
    let cornerRadius: CornerRadius
    let shadows: Shadows
}

// MARK: - Color Palette
struct ColorPalette {
    // Primary
    let primary: Color
    let primaryLight: Color
    let primaryDark: Color
    
    // Secondary
    let secondary: Color
    let secondaryLight: Color
    let secondaryDark: Color
    
    // Background
    let background: Color
    let backgroundSecondary: Color
    let surface: Color
    
    // Text
    let textPrimary: Color
    let textSecondary: Color
    let textDisabled: Color
    
    // Status
    let success: Color
    let warning: Color
    let error: Color
    let info: Color
    
    // Borders
    let border: Color
    let divider: Color
}

// MARK: - Typography
struct Typography {
    // Headlines
    let largeTitle: Font
    let title1: Font
    let title2: Font
    let title3: Font
    
    // Body
    let body: Font
    let bodyBold: Font
    let callout: Font
    
    // Small
    let caption: Font
    let footnote: Font
}

// MARK: - Spacing
struct Spacing {
    let xs: CGFloat = 4
    let sm: CGFloat = 8
    let md: CGFloat = 16
    let lg: CGFloat = 24
    let xl: CGFloat = 32
    let xxl: CGFloat = 48
}

// MARK: - Corner Radius
struct CornerRadius {
    let sm: CGFloat = 4
    let md: CGFloat = 8
    let lg: CGFloat = 12
    let xl: CGFloat = 16
    let round: CGFloat = 999
}

// MARK: - Shadows
struct Shadows {
    let small: (color: Color, radius: CGFloat, x: CGFloat, y: CGFloat)
    let medium: (color: Color, radius: CGFloat, x: CGFloat, y: CGFloat)
    let large: (color: Color, radius: CGFloat, x: CGFloat, y: CGFloat)
}

// MARK: - Theme Manager
class ThemeManager: ObservableObject {
    @Published var currentTheme: AppTheme
    
    init() {
        self.currentTheme = Self.defaultTheme
    }
    
    static var defaultTheme: AppTheme {
        AppTheme(
            colors: ColorPalette(
                primary: Color("Primary", bundle: .main),
                primaryLight: Color("PrimaryLight", bundle: .main),
                primaryDark: Color("PrimaryDark", bundle: .main),
                secondary: Color("Secondary", bundle: .main),
                secondaryLight: Color("SecondaryLight", bundle: .main),
                secondaryDark: Color("SecondaryDark", bundle: .main),
                background: Color("Background", bundle: .main),
                backgroundSecondary: Color("BackgroundSecondary", bundle: .main),
                surface: Color("Surface", bundle: .main),
                textPrimary: Color("TextPrimary", bundle: .main),
                textSecondary: Color("TextSecondary", bundle: .main),
                textDisabled: Color("TextDisabled", bundle: .main),
                success: Color("Success", bundle: .main),
                warning: Color("Warning", bundle: .main),
                error: Color("Error", bundle: .main),
                info: Color("Info", bundle: .main),
                border: Color("Border", bundle: .main),
                divider: Color("Divider", bundle: .main)
            ),
            typography: Typography(
                largeTitle: .system(size: 34, weight: .bold),
                title1: .system(size: 28, weight: .bold),
                title2: .system(size: 22, weight: .semibold),
                title3: .system(size: 20, weight: .semibold),
                body: .system(size: 17, weight: .regular),
                bodyBold: .system(size: 17, weight: .semibold),
                callout: .system(size: 16, weight: .regular),
                caption: .system(size: 12, weight: .regular),
                footnote: .system(size: 13, weight: .regular)
            ),
            spacing: Spacing(),
            cornerRadius: CornerRadius(),
            shadows: Shadows(
                small: (Color.black.opacity(0.1), 2, 0, 2),
                medium: (Color.black.opacity(0.15), 4, 0, 4),
                large: (Color.black.opacity(0.2), 8, 0, 8)
            )
        )
    }
}

// MARK: - Theme Environment Key
struct ThemeKey: EnvironmentKey {
    static let defaultValue = ThemeManager()
}

extension EnvironmentValues {
    var theme: ThemeManager {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

// MARK: - Usage Example
struct ThemedButtonExample: View {
    @Environment(\.theme) var themeManager
    
    var theme: AppTheme {
        themeManager.currentTheme
    }
    
    var body: some View {
        Button("Themed Button") {
            // Action
        }
        .font(theme.typography.body)
        .foregroundColor(.white)
        .padding(theme.spacing.md)
        .background(theme.colors.primary)
        .cornerRadius(theme.cornerRadius.md)
        .shadow(
            color: theme.shadows.medium.color,
            radius: theme.shadows.medium.radius,
            x: theme.shadows.medium.x,
            y: theme.shadows.medium.y
        )
    }
}