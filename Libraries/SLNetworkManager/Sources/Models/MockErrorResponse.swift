//
//  MockErrorResponse.swift
//  Pods
//
//  Created by Jose Julio Junior on 10/12/25.
//

import Foundation

public struct MockErrorResponse<E: Decodable>: Decodable {
    public var httpStatus: Int = 0
    public var errors: E?
    
    enum ResponseKeys: String, CodingKey {
        case httpStatus, results, errors
    }
    
    public init (from decoder: Decoder) throws {
        let container =  try decoder.container (keyedBy: ResponseKeys.self)

        httpStatus = (try? container.decodeIfPresent(Int.self, forKey: .httpStatus)) ?? 0
        errors = try? container.decodeIfPresent(E.self, forKey: .errors)
    }
}
