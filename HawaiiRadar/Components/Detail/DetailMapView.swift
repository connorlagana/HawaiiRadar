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
    
    @ObservedObject var vm = MapSearchingViewModel()
    
    var annotationArr: [MKPointAnnotation]?
    
    let mv = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        setupRegionForMap(lat: vm.coordinates.latitude, lon: vm.coordinates.longitude)
        return mv
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let annotationArr = annotationArr {
            uiView.addAnnotations(annotationArr)
        }
        
        setupRegionForMap(lat: vm.coordinates.latitude, lon: vm.coordinates.longitude)
        
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
    @Published var annotations = [MKPointAnnotation]()
    @Published var isSearching = false
    @Published var searchQuery = ""
    @Published var mapItems = [MKMapItem]()
    @Published var selectedMapItem: MKMapItem?
    @Published var beachItems = [BeachItem]()
    
    @Published var coordinates = CLLocationCoordinate2D(latitude: 20.914, longitude: -156.393)
    
    var cancellable: AnyCancellable?
    
    init() {
        print("Initializing view model")
    }
}

struct DetailMapView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailMapView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMapView()
    }
}
