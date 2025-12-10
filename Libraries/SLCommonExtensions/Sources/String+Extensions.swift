//
//  String+Extensions.swift
//  SLCommonExtensions
//
//  Created by Jose Julio on 25/11/25.
//

public extension String {
    func localized(tableName: String, bundle: Bundle, arguments: [CVarArg] = []) -> String {
        String(format: NSLocalizedString(self, tableName: tableName, bundle: bundle, comment: ""), arguments: arguments)
    }

    func localized(tableName: String, bundle: Bundle, arguments: CVarArg...) -> String {
        String(format: NSLocalizedString(self, tableName: tableName, bundle: bundle, comment: ""), arguments: arguments)
    }

    func trim() -> String {
       return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
