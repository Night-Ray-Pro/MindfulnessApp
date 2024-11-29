//
//  MapView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 22/11/24.
//

import SwiftUI
import MapKit
import CoreLocation


struct MapView: View {
    let locationFetcher = LocationFetcher()
    @State private var localPosition = false
    @State private var timesOfPositionChange = 0
    @Binding var locationName : String?
    @Binding var latitude: Double?
    @Binding var longitude: Double?
    @Environment(\.dismiss) var dismiss
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50.255441390654724, longitude: 19.02279275205155),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
        NavigationStack{
            ZStack{
                Map(position: $position)
                    .mapStyle(.standard)
                    .onMapCameraChange { context in
//                        print(context.region)
                        if localPosition == true && timesOfPositionChange < 1 {
                            
                            timesOfPositionChange += 1
                        } else{
                            timesOfPositionChange = 0
                            withAnimation{
                                localPosition = false
                            }
                            let newPosition = MapCameraPosition.region(context.region)
                            position = newPosition
                        }
                    }
                Image(.mapPointVector)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 100)
                    .offset(y: -40)
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button{
                            locationFetcher.start { location in
                                if let location = location {
                                    withAnimation {
                                        localPosition = true
                                        position = MapCameraPosition.region(
                                            MKCoordinateRegion(
                                                center: location,
                                                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                            )
                                        )
                                    }
                                } else {
                                    print("Your location is unknown")
                                }
                            }
                        } label: {
                            Image(systemName: localPosition ? "location.fill" : "location")
                                .resizable()
                                .scaledToFit()
                                .frame(width:25, height: 25)
                                .foregroundStyle(.black.opacity(0.5))
                                .padding(10)
                                .background(.ultraThickMaterial)
                                .preferredColorScheme(.light)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Add Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done"){
                        let location = CLLocation(latitude: position.region?.center.latitude ?? 0.0, longitude: position.region?.center.longitude ?? 0.0)
                        latitude = position.region?.center.latitude
                        longitude = position.region?.center.longitude
                        
                        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                            if let placemark = placemarks?.first{
                                print(placemark.locality ?? "NotFound", placemark.country ?? "NotFound")
                                locationName = "\(placemark.locality ?? "NotFound"), \(placemark.country ?? "NotFound")"
                            }
                        }
                        
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                
            }
        }
        

    }
}



class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    var onLocationUpdate: ((CLLocationCoordinate2D?) -> Void)?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        onLocationUpdate = completion
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        onLocationUpdate?(lastKnownLocation)
        manager.stopUpdatingLocation() // Stop updating to save battery
    }
}

#Preview {
    MapView(locationName: .constant("London"), latitude: .constant(51.507222), longitude: .constant(-0.1275))
}
