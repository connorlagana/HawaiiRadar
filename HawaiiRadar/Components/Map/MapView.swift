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

struct MapView: View {
    
    @ObservedObject var vm = MapSearchingViewModel()
    @State var isMenuShowing = false
    @State var mapType = false
    @State var selectedMapItem = MapSearchingViewModel().selectedMapItem
    @State var showingDetail = false
    
    var body: some View {
        NavigationView {
            ZStack {
                MapViewContainer(annotationArr: vm.annotations)
                    .ignoresSafeArea(edges: .all)
                //Menu Button
                MenuButton(isMenuShowing: $isMenuShowing)
                
                //Scroll Beaches
                VStack {
                    Spacer()
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(vm.beachItems, id: \.beach_id) { i in
                                MapButtonView(beach: i, showingDetail: $showingDetail, selectedMapItem: $selectedMapItem)
                            }
                        }.padding()
                    }
                }.padding(.bottom)
                
                //Gray background when menu button is pressed
                Color(.init(white: 0, alpha: self.isMenuShowing ? 0.5 : 0))
                    .edgesIgnoringSafeArea(.all)
                    .animation(.spring())
                
                //Slide out menu
                SlideOutMenu(isMenuShowing: $isMenuShowing)

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


