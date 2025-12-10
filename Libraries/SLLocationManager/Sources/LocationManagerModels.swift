//
//  LocationManagerModels.swift
//  SLLocationManager
//
//  Created by Jose Julio on 25/11/25.
//

public enum LocationManagerModels {

    public enum LocationStatus: String {
        case positionUnavailable = "POSITION_UNAVAILABLE"
        case timeOut = "TIMEOUT"
        case unknown = "UNKNOWN"
        case success = "SUCCESS"
        case empty = "EMPTY"
    }
    
    public enum AuthorizationStatus {
        case authorized
        case denied
        case notDetermined
    }
    
    public enum LocationError: Error {
        case deniedAuthorization
    }

    public struct Location: Codable {
        public let latitude: Double
        public let longitude: Double

        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
        
        enum CodingKeys: String, CodingKey {
            case latitude = "latitude"
            case longitude = "longitude"
        }
    }
}