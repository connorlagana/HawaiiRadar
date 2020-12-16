//
//  MapView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 12/15/20.
//

import SwiftUI
import MapKit

struct BeachItem: Decodable {
    let beach, island, shore, lat, lon, nearshore, offshore, updated: String
}

struct MapViewContainer: UIViewRepresentable {
    
    var annotationArr: [MKPointAnnotation]?
    
    let mv = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        setupRegionForMap()
        return mv
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let annotationArr = annotationArr {
            uiView.addAnnotations(annotationArr)
        }
        
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
    
    @State var annotations: [MKPointAnnotation]?
    @State var dummyAnnotation: MKPointAnnotation?
    
    @State var beachItems = [BeachItem]()
    
    
    var body: some View {
        ZStack {
            MapViewContainer(annotationArr: annotations)
                .ignoresSafeArea(edges: .all)
            VStack {
                Spacer()
                Button("Fetch Beaches") {
                    beachReport()
                }
            }
            
        }
        
    }
    
    func beachReport() {
        print("from beachReport")
        
        var items = [BeachItem]()
        var annos = [MKPointAnnotation]()
        
        let str = "https://hawaiibeachsafety.com/rest/ratings.json"
        guard let url = URL(string: str) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(Array<BeachItem>.self, from: data)
                items = res
                DispatchQueue.main.async {
                    for item in items {
                        let anno = MKPointAnnotation()
                        let lat = Double(item.lat) ?? 0
                        let lon = Double(item.lon) ?? 0
                        anno.title = item.beach
                        anno.coordinate = CLLocationCoordinate2D.init(latitude: lat, longitude: lon)
                        annos.append(anno)
                    }
                    annotations = annos
                }
                
            } catch {
                print("Failure: \(error)")
            }
            
        }.resume()
        
        
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


