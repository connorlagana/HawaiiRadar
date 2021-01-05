//
//  IslandView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 12/22/20.
//

import SwiftUI

struct IslandView: View {
    var beachToDisplay: String
    
    @State var beachConditions = [BeachCondition]()
    
    var body: some View {
        
        ZStack {
            //Linear Background Gradient
            LinearGradient.init(gradient: Gradient(colors: [Color.init(red: 180/255, green: 190/255, blue: 198/255, opacity: 1), Color.init(red: 85/255, green: 85/255, blue: 115/255, opacity: 1)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(edges: .all)
            
            VStack(alignment: .center) {
                
                IslandHeader(beachToDisplay: self.beachToDisplay)
                
                IslandScrollView(beachConditions: self.beachConditions)
                
                
            }
            .navigationBarHidden(true)
            .onAppear(perform: {
                Api().getislandData(island: beachToDisplay) { (posts) in
                    self.beachConditions = posts
                    
                }
            })
        }
        
        
        
        
        
    }
}

struct TestButtonView: View {
    
    @State var showingDetail = false
    
    var body: some View {
        
        NavigationView {
            
            NavigationLink(
                destination: IslandView(beachToDisplay: "Oahu"),
//                    .ignoresSafeArea(edges: .all),
                label: {
                    HStack {
                        Text("Click")
                        Text("Click Here")
                    }
                })
            
        }
        
        
    }
}



struct IslandView_Previews: PreviewProvider {
    static var previews: some View {
        TestButtonView()
    }
}
