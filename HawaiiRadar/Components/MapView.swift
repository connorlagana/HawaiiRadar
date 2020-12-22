//
//  MapView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 12/15/20.
//

import SwiftUI
import MapKit
import Combine

struct BeachItem: Decodable{
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
    @Published var beachItems = [BeachItem]()
    
    @Published var coordinates = CLLocationCoordinate2D(latitude: 20.914, longitude: -156.393)
    
    var cancellable: AnyCancellable?
    
    init() {
        print("Initializing view model")
        // combine code
//        cancellable = $searchQuery.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
//            .sink { [weak self] (searchTerm) in
//                self?.searchForMapItem(arr: self?.performSearch() ?? [])
//        }
//        performSearch()
    }
    
    func performSearch(){
        print("from performSearch")
        let str = "https://hawaiibeachsafety.com/rest/ratings.json"
        guard let url = URL(string: str) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(Array<BeachItem>.self, from: data)
                
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
    
    func searchForMapItem(arr: [BeachItem]) {
        isSearching = true
        print("From searchForMapItem")
        print("Arr: \(arr)")
        
        //Step 2: For each in Beach Items Array, find each MKMapItem
        for item in arr {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "\(item.beach), Hawaii"
            print("\(item.beach), Hawaii")
            
            let localSearch = MKLocalSearch(request: request)
            localSearch.start { (resp, err) in
                // handle your error
                
//                self.mapItems = resp?.mapItems ?? []
                
                
                
                resp?.mapItems.forEach({ (mapItem) in
                    print(mapItem.name ?? "")
                    let annotation = MKPointAnnotation()
                    annotation.title = mapItem.name
                    annotation.coordinate = mapItem.placemark.coordinate
                    self.annotations.append(annotation)
                    self.mapItems.append(mapItem)
                })
                
                self.isSearching = false
                
                
            }
            
        }
    }
}


struct MapView: View {
    
    @ObservedObject var vm = MapSearchingViewModel()
    @State var isMenuShowing = false
    @State var mapType = false
    
    let islands: [String] = ["Hawai'i", "Maui", "O'ahu", "Kaua'i"]
    
    
    var body: some View {
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
            
            Color(.init(white: 0, alpha: self.isMenuShowing ? 0.5 : 0))
                .edgesIgnoringSafeArea(.all)
                .animation(.spring())
            
            HStack {
                ZStack {
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.isMenuShowing.toggle()
                        }
                    VStack {
                        HStack {
                            Text("Menu").font(.system(size: 26, weight: .black, design: Font.Design.default))
                            Spacer()
                        }.padding()
                        
                        VStack {
                            ForEach(islands, id: \.self) { island in
                                Button(action: {
                                    
                                    
                                    
                                }, label: {
                                    Text(island)
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
//            VStack {
//                Button("Fetch Beaches") {
////                    vm.performSearch()
//                }
//                Spacer()
//                ScrollView(.horizontal) {
//
//                    HStack {
//                        ForEach(vm.mapItems, id: \.self) { item in
//                            HStack {
//                                VStack {
//                                    Text(item.name ?? "")
//                                }
//                            }
//
//                            .frame(width: 250, height: 120, alignment: .center)
//                            .background(Color.white)
//                            .cornerRadius(20)
//                            .animation(.easeIn)
//                        }
//                    }
//
//                }
//            }

        }.onAppear() {
//            vm.performSearch()
        }
//        List(vm.beachItems) { post in
//            Text(post.beach)
//        }
//        .onAppear() {
//            print("On appear")
//            vm.performSearch { (posts) in
//                vm.beachItems = posts
//            }
//        }
        
        
    }
    
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


