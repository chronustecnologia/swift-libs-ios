//
//  ContentType.swift
//  SLNetworkManager
//
//  Created by Jose Julio on 09/12/25.
//

import Foundation

public enum ContentType: String {
    case json = "application/json"
    case formUrlEncoded = "application/x-www-form-urlencoded"
    case multipartFormData = "multipart/form-data"
    
    var headerValue: String {
        return self.rawValue
    }
}