//
//  MapSearchingViewModel.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/21/21.
//

import SwiftUI
import MapKit
import Combine
import CoreLocation

class MapSearchingViewModel: ObservableObject {
    @Published var annotations = [MKPointAnnotation]()
    @Published var isSearching = false
    @Published var searchQuery = ""
    @Published var mapItems = [MKMapItem]()
    @Published var selectedMapItem: BeachCondition?
    @Published var beachItems = [BeachCondition]()
    
    var locationManager = CLLocationManager()
    
    @Published var coordinates = CLLocationCoordinate2D(latitude: 21.363921153800, longitude: -157.709575888900)
    
    var cancellable: AnyCancellable?
    
    var currentLoc: CLLocation!
    
    init() {
        performSearch()
    }
    
    func performSearch() {
        print("from performSearch")
        let str = "https://hawaiibeachsafety.com/rest/conditions.json"
        guard let url = URL(string: str) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(Array<BeachCondition>.self, from: data)
                
                    //Step 1: Fetch API data and store in Beach Items Array
                    
                DispatchQueue.main.async {
                    self.beachItems = res
                    print("beachItems: ", self.beachItems)
                    self.searchForMapItem(arr: res)
                }
                
            } catch {
                print("Failure: \(error)")
            }
        }.resume()
        
        
    }
    
    func searchForMapItem(arr: [BeachCondition]) {
        isSearching = true
        print("From searchForMapItem")
        print("Arr: \(arr)")
        
        var annos: [MKPointAnnotation] = []
        //Step 2: For each in Beach Items Array, find each MKMapItem
        for item in arr {
            let anno = MKPointAnnotation()
            anno.title = item.beach
            anno.coordinate = .init(latitude: Double(item.lat) ?? 0, longitude: Double(item.lon) ?? 0)
            
            annos.append(anno)
        }
        
        self.annotations = annos
    }
}
