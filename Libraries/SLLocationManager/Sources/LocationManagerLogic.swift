//
//  LocationManagerLogic.swift
//  SLLocationManager
//
//  Created by Jose Julio on 25/11/25.
//

import CoreLocation

public protocol LocationManagerLogic {
    var locationStatus: LocationManagerModels.LocationStatus { get }
    var clLocation: CLLocation? { get }
    var isAuthorized: Bool { get }
    var authorizationStatus: LocationManagerModels.AuthorizationStatus { get }
    var location: LocationManagerModels.Location { get }
    
    func requestAuthorization(_ requestAuthorization: Bool, completion: @escaping (Bool) -> Void)
    func startLocationUpdate(_ completion: @escaping (Result<LocationManagerModels.Location, LocationManagerModels.LocationError>) -> Void)
    func stopLocationUpdate()
    func requesUserLocation()
}