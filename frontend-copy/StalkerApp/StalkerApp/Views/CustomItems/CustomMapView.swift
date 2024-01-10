//
//  CustomMapView.swift
//  StalkerApp
//
//  Created by Sarah Largou on 22.12.23.
//

import SwiftUI
import MapKit

// custom map view since there is no working map view on the main branch.
struct CustomMapView: View {
    var body: some View {
        // region property shows the position which is passed
        // through the coordinates in the priv var region
        Map(initialPosition: .region(region))
    }
    private var region: MKCoordinateRegion {
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 51.353680977535454, longitude: 6.153520897107757),
                // determines how much of the map is visible basically
                // play around with the values to test it if you want the lower the value the closer is what i learned
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        }
}

#Preview {
    CustomMapView()
}
