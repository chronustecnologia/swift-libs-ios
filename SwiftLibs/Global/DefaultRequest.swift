//
//  DefaultRequest.swift
//  SwiftLibs
//
//  Created by Jose Julio Junior on 10/12/25.
//

import SLNetworkManager

final class DefaultRequest: NetworkRequestProtocol {
    var endpoint: String { "/typicode/demo/profile" }
    var method: HTTPMethod { .get }
}
