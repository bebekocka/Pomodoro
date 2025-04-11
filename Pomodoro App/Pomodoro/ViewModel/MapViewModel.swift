//
//  MapViewModel.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import MapKit

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = CLLocationCoordinate2D(latitude: 47.497913, longitude: 19.040236)
    @Published var isLocationSelected = false
    @Published var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var locationManager = CLLocationManager()
    
    func checkIfLocationServicesEnabled()  {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
        } else {
            print("Location services are not enabled")
        }
    }
    
    private func checkLocationAuthorization() {
        let locationManager = locationManager
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location services are restricted")
        case .denied:
            print("Location services are denied to changeit go to: Settings>Privacy>Location Services")
        case .authorizedAlways, .authorizedWhenInUse:
            region = locationManager.location?.coordinate ?? .budapest
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    
    
}


