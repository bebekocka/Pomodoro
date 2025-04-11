//
//  MapView.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import MapKit
import SwiftUI

extension CLLocationCoordinate2D {
    static var budapest = CLLocationCoordinate2D(latitude: 47.497913, longitude: 19.040236)
}
struct MapView: View {
    @Environment(\.dismiss) var dismiss
    var latitude: Double
    var longitude: Double
    @StateObject private var mapView = MapViewModel()
    
    var body: some View {
        Map(){
            Marker("Task Location",coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            Annotation("Current Location", coordinate: mapView.region, anchor: .bottom){
                Image(systemName: "figure.wave")
                    .padding(4)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .onAppear  {
            mapView.checkIfLocationServicesEnabled()
        }
        .colorScheme(.dark)
    }
}

