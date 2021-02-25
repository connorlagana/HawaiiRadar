//
//  DetailMapView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/5/21.
//

import SwiftUI
import MapKit
import Combine

struct MapViewContainer2: UIViewRepresentable {
    let mv = MKMapView()
    
    var annotation: MKPointAnnotation?
    var beachCon: BeachCondition?
    
    
    func makeUIView(context: Context) -> MKMapView {
        
        //THIS IS REALLY BAD CODE BUT IT WORKS SO AS OF RIGHT NOW IM GONNA LEAVE IT BC IM REALLY TIRED RN
        setupRegionForMap(lat: Double(beachCon!.lat)!, lon: Double(beachCon!.lon)!)
        return mv
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        if let annotation = annotation {
            uiView.addAnnotation(annotation)
        }
        
    }
    
    typealias UIViewType = MKMapView
    
    fileprivate func setupRegionForMap(lat: Double, lon: Double) {
        let centerCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mv.setRegion(region, animated: true)
    }
    
}

class MapSearchingViewModel2: ObservableObject {
    
    @Published var coordinates = CLLocationCoordinate2D(latitude: 20.914, longitude: -156.393)
    
    var cancellable: AnyCancellable?
    
    init() {
        print("Initializing view model")
    }
}

struct DetailMapView: View {
    
    @State var annotation: MKPointAnnotation?
    
    var beach: BeachCondition
    
    var body: some View {
        MapViewContainer2(annotation: annotation, beachCon: beach)
            .frame(height: 350)
            .onAppear(perform: {
                let anno = MKPointAnnotation()
                anno.title = beach.beach
                
                anno.coordinate = .init(latitude: Double(beach.lat) ?? 0, longitude: Double(beach.lon) ?? 0)
                self.annotation = anno
                
                
            })
    }
}

