//
//  StorageService.swift
//  SLStorageInterface
//
//  Created by Jose Julio on 25/11/25.
//

import Foundation

public protocol StorageService: AnyObject {
    func saveKeychain(key: KeychainKeys, value: Codable?)
    func fetchKeychain<T: Codable>(model: T.Type, key: KeychainKeys) -> T?
    func deleteKeychain(key: KeychainKeys)
    func saveTemporary(key: TemporaryKeys, value: Codable?)
    func fetchTemporary<T: Codable>(model: T.Type, key: TemporaryKeys) -> T?
    func deleteTemporary(key: TemporaryKeys)
}
