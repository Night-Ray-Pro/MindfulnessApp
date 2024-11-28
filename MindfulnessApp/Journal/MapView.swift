//
//  MapView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 22/11/24.
//

import SwiftUI
import MapKit


struct MapView: View {
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
                Map(initialPosition: position)
                    .mapStyle(.standard)
                    .onMapCameraChange { context in
//                        print(context.region)
                        let newPosition = MapCameraPosition.region(context.region)
                        position = newPosition
                    }
                Image(.mapPointVector)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 100)
                    .offset(y: -40)
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

#Preview {
    MapView(locationName: .constant("London"), latitude: .constant(51.507222), longitude: .constant(-0.1275))
}
