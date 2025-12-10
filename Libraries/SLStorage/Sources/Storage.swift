//
//  Storage.swift
//  SLStorage
//
//  Created by Jose Julio on 25/11/25.
//

import Foundation
import SLStorageInterface
import KeychainSwift

public final class Storage: StorageService {
    
    //MARK: - Singleton
    
    public static var shared: StorageService = Storage()

    //MARK: - Objects
    
    private let keychain: KeychainSwift
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    private var temporaryList: [TemporaryKeys: Codable?] = [:]

    // MARK: - Lifecycle
    
    init(keychain: KeychainSwift = KeychainSwift(),
         decoder: JSONDecoder = JSONDecoder(),
         encoder: JSONEncoder = JSONEncoder()) {
        self.keychain = keychain
        self.decoder = decoder
        self.encoder = encoder
        self.encoder.outputFormatting = .prettyPrinted
        self.decoder.keyDecodingStrategy = .useDefaultKeys
    }

    // MARK: Keychain

    public func saveKeychain(key: KeychainKeys, value: Codable?) {
        guard let value else { keychain.delete(key.rawValue); return }
        if let stringValue = value as? String { saveKeychainString(key: key, value: stringValue) }
        else if let boolValue = value as? Bool { saveKeychainBool(key: key, value: boolValue) }
        else if let encodedData = try? encoder.encode(value) { saveKeychainData(key: key, value: encodedData) }
        else { keychain.delete(key.rawValue) }
    }
    
    public func fetchKeychain<T: Codable>(model: T.Type, key: KeychainKeys) -> T? {
        let semaphore = DispatchSemaphore(value: 0)
        var resultValue: T?
        
        if model is String.Type {
            Task {
                resultValue = try? await fetchStringKeychain(key: key) as? T
                semaphore.signal()
            }
            
        } else if model is Bool.Type {
            Task {
                resultValue = try? await fetchBoolKeychain(key: key) as? T
                semaphore.signal()
            }
        } else {
            Task {
                if let dataValue = try? await fetchDataKeychain(key: key) {
                    resultValue = try? decoder.decode(model.self, from: dataValue)
                }
                semaphore.signal()
            }
        }
        _ = semaphore.wait(timeout: .now() + 5)
        return resultValue
    }
    
    public func deleteKeychain(key: KeychainKeys) {
        keychain.delete(key.rawValue)
    }

    // MARK: Temporarily
    
    public func saveTemporary(key: TemporaryKeys, value: Codable?) {
        temporaryList[key] = value
    }
    
    public func fetchTemporary<T: Codable>(model: T.Type, key: TemporaryKeys) -> T? {
        guard temporaryList.keys.contains(where: { $0 == key }), let value = temporaryList[key] else { return nil }
        return value as? T
    }
    
    public func deleteTemporary(key: TemporaryKeys) {
        temporaryList.removeValue(forKey: key)
    }

    // MARK: - Private Functions
    
    private func saveKeychainString(key: KeychainKeys, value: String) {
        keychain.set(value, forKey: key.rawValue, withAccess: .accessibleAfterFirstUnlock)
    }
    
    private func saveKeychainBool(key: KeychainKeys, value: Bool) {
        keychain.set(value, forKey: key.rawValue, withAccess: .accessibleAfterFirstUnlock)
    }
    
    private func saveKeychainData(key: KeychainKeys, value: Data) {
        keychain.set(value, forKey: key.rawValue, withAccess: .accessibleAfterFirstUnlock)
    }
    
    private func fetchStringKeychain(key: KeychainKeys) async throws -> String? {
        try await withThrowingTaskGroup(of: String?.self) { group in
            for _ in 0...5 {
                group.addTask { return self.keychain.get(key.rawValue) }
            }
            var result: String?
            for try await value in group {
                if let value { result = value }
            }
            return result
        }
    }
    
    private func fetchBoolKeychain(key: KeychainKeys) async throws -> Bool? {
        try await withThrowingTaskGroup(of: Bool?.self) { group in
            for _ in 0...5 {
                group.addTask { return self.keychain.getBool(key.rawValue) }
            }
            var result: Bool?
            for try await value in group {
                if let value { result = value }
            }
            return result
        }
    }
    
    private func fetchDataKeychain(key: KeychainKeys) async throws -> Data? {
        try await withThrowingTaskGroup(of: Data?.self) { group in
            for _ in 0...5 {
                group.addTask { return self.keychain.getData(key.rawValue) }
            }
            var result: Data?
            for try await value in group {
                if let value { result = value }
            }
            return result
        }
    }
}
