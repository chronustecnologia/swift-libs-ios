//
//  Date+Extensions.swift
//  SLCommonExtensions
//
//  Created by Jose Julio on 25/11/25.
//

import Foundation

extension Date {
    enum TimeZoneIdentifier {
        case americaSP
        case current
        
        var identifier: String {
            switch self {
            case .americaSP:
                return "America/Sao_Paulo"
            default:
                return TimeZone.current.identifier
            }
        }
    }
}