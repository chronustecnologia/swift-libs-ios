//
//  Localizable+Extensions.swift
//  SLCommonExtensions
//
//  Created by Jose Julio on 25/11/25.
//

import Foundation

public protocol Localizable {
    var tableName: String { get }
    var bundle: Bundle? { get }

    func string(_ arguments: [CVarArg]) -> String
    func string(_ arguments: CVarArg...) -> String
}

public extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    func string(_ arguments: [CVarArg] = []) -> String {
        rawValue.localized(tableName: tableName, bundle: bundle ?? .main, arguments: arguments)
    }

    func string(_ arguments: CVarArg...) -> String {
        rawValue.localized(tableName: tableName, bundle: bundle ?? .main, arguments: arguments)
    }
}
