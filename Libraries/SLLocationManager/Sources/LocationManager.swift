//
//  LocationManager.swift
//  SLLocationManager
//
//  Created by Jose Julio on 25/11/25.
//

import CoreLocation

final public class LocationManager: NSObject, CLLocationManagerDelegate, LocationManagerLogic {
    
    private var locationHandler: ((Result<LocationManagerModels.Location, LocationManagerModels.LocationError>) -> Void)?
    private var authorizationHandler: ((Bool) -> Void)?
    private var locationManager: CLLocationManager
    
    // MARK: - Singleton
    
    public static let shared: LocationManagerLogic = LocationManager()
    
    // MARK: - LifeCycle
    
    public init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    // MARK: - Logic
    
    public var locationStatus: LocationManagerModels.LocationStatus {
        isAuthorized ? LocationManagerModels.LocationStatus.success : LocationManagerModels.LocationStatus.positionUnavailable
    }
    
    public var clLocation: CLLocation? { locationManager.location }
    
    public var isAuthorized: Bool {
        let status = CLLocationManager.authorizationStatus()
        return status == .authorizedAlways || status == .authorizedWhenInUse
    }
    
    public var authorizationStatus: LocationManagerModels.AuthorizationStatus {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined, .restricted:
            return .notDetermined
        case .denied:
            return .denied
        case .authorizedAlways, .authorizedWhenInUse:
            return .authorized
        default:
            return .notDetermined
        }
    }
    
    public var location: LocationManagerModels.Location {
        .init(latitude: locationManager.location?.coordinate.latitude ?? 0,
              longitude: locationManager.location?.coordinate.longitude ?? 0)
    }
    
    public func requesUserLocation() {
        locationManager.requestLocation()
    }
    
    public func requestAuthorization(_ requestAuthorization: Bool, completion: @escaping (Bool) -> Void) {
        authorizationHandler = completion
        requestAuthorizationIfNeeded(requestAuthorization)
    }
    
    public func stopLocationUpdate() {
        locationManager.stopUpdatingLocation()
        locationHandler = nil
    }

    public func startLocationUpdate(_ completion: @escaping (Result<LocationManagerModels.Location, LocationManagerModels.LocationError>) -> Void) {
        locationHandler = completion
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Private Functions
    
    private func requestAuthorizationIfNeeded(_ requestAuthorization: Bool) {
        switch CLLocationManager.authorizationStatus() {
        case .denied, .restricted:
            handleAuthorizationStatusFail()
        case .authorizedAlways, .authorizedWhenInUse:
            handleAuthorizationStatusSuccess()
        default:
            if requestAuthorization { locationManager.requestWhenInUseAuthorization() }
        }
    }
    
    private func handleLocationFail() {
        locationHandler?(.failure(.deniedAuthorization))
        stopLocationUpdate()
    }
    
    private func handleLocationSuccess() {
        locationHandler?(.success(location))
        stopLocationUpdate()
    }
    
    private func handleAuthorizationStatusSuccess() {
        guard let authorizationHandler = authorizationHandler else { return }
        authorizationHandler(true)
        self.authorizationHandler = nil
    }
    
    private func handleAuthorizationStatusFail() {
        guard let authorizationHandler = authorizationHandler else { return }
        authorizationHandler(false)
        self.authorizationHandler = nil
    }
    
    // MARK: - CLLocationManagerDelegate
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            handleAuthorizationStatusSuccess()
        default:
            handleAuthorizationStatusFail()
            handleLocationFail()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        handleLocationSuccess()
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        handleLocationFail()
        
        if let clErr = error as? CLError, clErr.code != .denied {
            handleAuthorizationStatusFail()
        }
    }
}

