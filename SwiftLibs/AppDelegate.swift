//
//  AppDelegate.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 25/11/25.
//

import UIKit
import SLNetworkManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureNetworkManager()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    private func configureNetworkManager() {
        var defaultHeaders: [String: String] = [
            "Accept": "application/json",
            "Accept-Language": Locale.current.languageCode ?? "pt-BR",
            "x-app-version": AppVersion.current,
            "x-app-build": AppVersion.buildNumber,
            "x-plataform": "iOS",
            "x-os-version": UIDevice.current.systemVersion,
            "x-device-model": UIDevice.current.model
        ]
        
        if let deviceId = UIDevice.current.identifierForVendor?.uuidString {
            defaultHeaders["x-device-identifier"] = deviceId
        }
        
        let configuration = NetworkConfiguration(
            baseURL: Environment.current.baseURL,
            defaultHeaders: defaultHeaders,
            timeoutInterval: 30,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            certificateValidation: Environment.current.certificateValidation
        )
        
        let logger = DefaultNetworkLogger(isEnabled: Environment.current.isLoggingEnabled)
        NetworkManager.configure(with: configuration, logger: logger)
        
        print("✅ NetworkManager configurado")
        print("📍 Base URL: \(Environment.current.baseURL)")
        print("🔍 Logging: \(Environment.current.isLoggingEnabled ? "Ativado" : "Desativado")")
    }

}

