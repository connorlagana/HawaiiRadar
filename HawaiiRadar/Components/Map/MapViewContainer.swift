//
//  MapViewContainer.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/21/21.
//

import SwiftUI
import MapKit

struct MapViewContainer: UIViewRepresentable {
    
    @ObservedObject var vm = MapSearchingViewModel()
    
    var annotationArr: [MKPointAnnotation]?
    
    let mapView = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        setupRegionForMap(lat: vm.coordinates.latitude, lon: vm.coordinates.longitude)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let annotationArr = annotationArr {
            uiView.addAnnotations(annotationArr)
        }
        
        setupRegionForMap(lat: vm.coordinates.latitude, lon: vm.coordinates.longitude)
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let postAnnotation = view.annotation as? MKPointAnnotation else {
            return
        }

        if let post = annotationArr?[0] {
            print("postHist: ", post)
        } else { return }
        // do something with post
    }
    
    typealias UIViewType = MKMapView
    
    fileprivate func setupRegionForMap(lat: Double, lon: Double) {
        let centerCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
}
