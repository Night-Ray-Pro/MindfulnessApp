//
//  MapView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 22/11/24.
//

import SwiftUI
import MapKit


struct MapView: View {
    
    let location = CLLocation(latitude: 50.255441390654724, longitude: 19.02279275205155)
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50.255441390654724, longitude: 19.02279275205155),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    var body: some View {
        ZStack{
            Map(initialPosition: position)
                .mapStyle(.standard)
                .onMapCameraChange { context in
                    print(context.region)
                    let newPosition = MapCameraPosition.region(context.region)
                    position = newPosition
                    }
            Button{
                let location2 = CLLocation(latitude: position.region?.center.latitude ?? 0.0, longitude: position.region?.center.longitude ?? 0.0)
                
                CLGeocoder().reverseGeocodeLocation(location2) { placemarks, error in
                    if let placemark = placemarks?.first{
                        print(placemark.locality ?? "NotFound", placemark.country ?? "NotFound")
                    }
                }
            } label: {
                Text("Test")
                    .font(.title)
            }
        }

    }
}

#Preview {
    MapView()
}
