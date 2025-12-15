//
//  Int+Extensions.swift
//  Pods
//
//  Created by Jose Julio Junior on 15/12/25.
//

extension Int {
    var isHTTPSuccess: Bool {
        return 200..<300 ~= self
    }
}
