//
//  Encodable+Extensions.swift
//  SLCommonExtensions
//
//  Created by Jose Julio on 25/11/25.
//

public extension Encodable {
    func toJSON(dateFormat: String? = nil) -> [String: Any]? {
        let jsonEncoder = JSONEncoder()
        if let dateFormat = dateFormat {
            let formatter = DateFormatter()
            formatter.dateFormat = dateFormat
            jsonEncoder.dateEncodingStrategy = .formatted(formatter)
        }
        jsonEncoder.dataEncodingStrategy = .base64
        do {
            let jsonData = try jsonEncoder.encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as! [String: Any]
            return dictionary
        } catch {
            print("toJSON fail!!")
            return nil
        }
    }
    
    func toStringDictionary() -> [String: String]? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        do {
            let jsonData = try encoder.encode(self)
            if let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                var stringDictionary: [String: String] = [:]
                for (key, value) in jsonDictionary {
                    if let strValue = value as? String {
                        stringDictionary[key] = strValue
                    } else {
                        stringDictionary[key] = "\(value)"
                    }
                }
                return stringDictionary
            }
        } catch {
            print("Error encoding or decoding: \(error)")
        }
        return nil
    }
}