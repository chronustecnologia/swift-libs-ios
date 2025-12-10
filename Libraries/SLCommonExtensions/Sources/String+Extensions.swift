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
    
    func dateFromISO8601() -> Date {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(identifier: Date.TimeZoneIdentifier.americaSP.identifier)
        formatter.formatOptions = [.withDay, .withMonth, .withYear, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        if let date = formatter.date(from: self) {
            return date
        } else {
            return Date()
        }
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String? {
        return self.data(using: .utf8)?.base64EncodedString(options: [])
    }
}
