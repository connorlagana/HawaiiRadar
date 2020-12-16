//
//  MapView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 12/15/20.
//

import SwiftUI
import MapKit

struct MapViewContainer: UIViewRepresentable {
    
    let mv = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        setupRegionForMap()
        return mv
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //
    }
    
    typealias UIViewType = MKMapView
    
    fileprivate func setupRegionForMap() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 21.593, longitude: -158.108)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mv.setRegion(region, animated: true)
    }
    
}

struct MapView: View {
    var body: some View {
        ZStack {
            MapViewContainer()
                .ignoresSafeArea(edges: .all)
            VStack {
                Spacer()
                Button("hello") {
                    print("hello")
                }
            }
            
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


