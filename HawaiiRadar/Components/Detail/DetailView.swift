//
//  DetailView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 12/30/20.
//

import SwiftUI

struct DetailView: View {
    var beach: BeachCondition
    
    @State var beachConditions = [BeachCondition]()
    
    let lightYellow = Color.init(red: 227/255, green: 182/255, blue: 72/255, opacity: 1)
    let darkYellow = Color.init(red: 222/255, green: 122/255, blue: 42/255, opacity: 1)
    
    let temps = [FutureTempHour(id: 1, hour: 1, temp: 69), FutureTempHour(id: 2, hour: 2, temp: 71), FutureTempHour(id: 3, hour: 3, temp: 72), FutureTempHour(id: 4, hour: 4, temp: 70), FutureTempHour(id: 5, hour: 5, temp: 66), FutureTempHour(id: 6, hour: 6, temp: 64), FutureTempHour(id: 7, hour: 7, temp: 63)]
    
    var body: some View {
        ScrollView {
            DetailHeader()
            CurrentTempDetail(beach: beach)
            Divider().background(Color.white)
//            DetailHScroll(hourTemps: temps)
            SurfView(beach: beach)
            Divider().background(Color.white)
            DetailMapView(beach: beach)
        }
        .background(LinearGradient.init(gradient: Gradient.init(colors: [lightYellow, darkYellow]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            Api().getislandData(island: "Oahu") { (posts) in
                self.beachConditions = posts
                
            }
        })
    }
}

