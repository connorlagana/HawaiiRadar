//
//  MapView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 12/15/20.
//

import SwiftUI
import MapKit
import Combine
import CoreLocation

struct BeachItem: Decodable, Hashable {
    let beach, island, shore, lat, lon, nearshore, offshore, updated: String
}

struct MapViewContainer: UIViewRepresentable {
    
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

class MapSearchingViewModel: ObservableObject {
    @Published var annotations = [MKPointAnnotation]()
    @Published var isSearching = false
    @Published var searchQuery = ""
    @Published var mapItems = [MKMapItem]()
    @Published var selectedMapItem: MKMapItem?
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


struct MapView: View {
    
    @ObservedObject var vm = MapSearchingViewModel()
    @State var isMenuShowing = false
    @State var mapType = false
    
    let islands: [String] = ["Big Island", "Maui", "Oahu", "Kauai"]
    
    
    var body: some View {
        NavigationView {
            ZStack {
                MapViewContainer(annotationArr: vm.annotations)
                    .ignoresSafeArea(edges: .all)
                HStack {
                    VStack {
                        Button(action: {
                            self.isMenuShowing.toggle()
                        }, label: {
                            Image(systemName: "line.horizontal.3.decrease.circle.fill")
                                .font(.system(size: 44))
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        })
                        
                        Spacer()
                    }
                    Spacer()
                }.padding()
                
                VStack {
                    Spacer()
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(vm.beachItems, id: \.beach_id) { i in
                                MapButtonView(beach: i)
                            }
                        }.padding()
                    }
                }.padding(.bottom)
                
                Color(.init(white: 0, alpha: self.isMenuShowing ? 0.5 : 0))
                    .edgesIgnoringSafeArea(.all)
                    .animation(.spring())
                
                HStack {
                    ZStack {
                        Color.init(red: 50/255, green: 50/255, blue: 125/255, opacity: 1)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                self.isMenuShowing.toggle()
                            }
                        VStack {
                            HStack {
                                Text("Menu")
                                    .foregroundColor(.white)
                                    .font(Font.custom("Nunito-Bold", size: 30))
                                Spacer()
                            }.padding()
                            
                            VStack {
                                ForEach(islands, id: \.self) { island in
                                    
                                        
                                    NavigationLink(
                                        destination: IslandView(beachToDisplay: island),
                        //                    .ignoresSafeArea(edges: .all),
                                        label: {
                                            VStack {
                                                Text(island)
                                                    .foregroundColor(.white)
                                                    .font(Font.custom("Nunito-Regular", size: 24))
                                                
                                                Divider().background(Color.white)
                                            }.frame(height: 60, alignment: .center)
                                        })
                                        
                                    
                                }
                            }
                            
                            Spacer()
                        }
                        
                        
                    }
                    .frame(width: 200)
                    Spacer()
                }
                .offset(x: self.isMenuShowing ? 0 : -200)
                .animation(.easeInOut)

            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ignoresSafeArea(edges: .all)
        
        
    }
    
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


