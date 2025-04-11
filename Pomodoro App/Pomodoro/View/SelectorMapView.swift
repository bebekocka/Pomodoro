//
//  SelectorMapView.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import MapKit
import SwiftUI

struct SelectorMapView: View {
    @StateObject private var mapView = MapViewModel()
    @Binding var lati: Double
    @Binding var longi: Double
    @Binding var addedLocation: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        MapReader{ proxy in
            Map{
                Annotation("Current Location", coordinate: mapView.region, anchor: .bottom){
                    Image(systemName: "figure.wave")
                        .padding(4)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                if mapView.isLocationSelected {
                    Marker("Selected Location", coordinate: mapView.coordinate)
                }
            }
            .onAppear{
                mapView.checkIfLocationServicesEnabled()
            }
            .colorScheme(.dark)
            .safeAreaInset(edge: .bottom){
                HStack{
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Label("Cancel", systemImage: "xmark.circle.fill" )
                    }
                    .foregroundColor(.red)
                    .buttonStyle(.bordered)
                    .contentShape(Rectangle())
                    .padding(.top)
                    
                    Spacer()
                    Button(action: {
                        lati = mapView.coordinate.latitude
                        longi = mapView.coordinate.longitude
                        addedLocation = true
                        dismiss()
                    }) {
                        Label("Add Location", systemImage: "location.circle.fill" )
                    }
                    .buttonStyle(.bordered)
                    .contentShape(Rectangle())
                    .padding(.top)
                    
                    Spacer()
                }
                .background(.thinMaterial.opacity(0.97))
            }
            .onTapGesture { position in
                if let loc = proxy.convert(position, from: .local){
                    mapView.isLocationSelected.toggle()
                    mapView.coordinate = loc
                }
            }
        }
    }
}

struct SelectorMapView_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectorMapView(lati: .constant(47.2), longi: .constant(52.3), addedLocation: .constant(false))
    }
}
