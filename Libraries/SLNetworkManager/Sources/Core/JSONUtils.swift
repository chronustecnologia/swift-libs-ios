//
//  JSONUtils.swift
//  Pods
//
//  Created by Jose Julio Junior on 10/12/25.
//

import Foundation
import SLCommonExtensions

protocol JSONUtilsLogic {
    func convertMock<E: Codable>(jsonData: Data, customError: E.Type?) -> MockErrorResponse<E>?
    func convertMock<T: Codable, E: Codable>(jsonData: Data, to model: T.Type, customError: E.Type) -> MockResponse<T, E>?
}

final class JSONUtils: JSONUtilsLogic {
    
    func convertMock<T: Codable, E: Codable>(jsonData: Data, to model: T.Type, customError: E.Type) -> MockResponse<T, E>? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        let result = try? decoder.decode(MockResponse<T, E>.self, from: jsonData)
        return result
    }
    
    func convertMock<E: Codable>(jsonData: Data, customError: E.Type?) -> MockErrorResponse<E>? {
        let decoder = JSONDecoder()
        let result = try? decoder.decode(MockErrorResponse<E>.self, from: jsonData)
        return result
    }
    
    public var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .custom({ (decoder) -> Date in
        let container = try decoder.singleValueContainer()
        let dateStr = try container.decode(String.self)
        return dateStr.dateFromISO8601()
    })
}
