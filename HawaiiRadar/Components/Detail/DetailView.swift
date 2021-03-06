//
//  DetailView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 12/30/20.
//

import SwiftUI

struct DetailView: View {
    var beach: BeachCondition
    
    @Binding var showingDetail: Bool
    
    @State var firstColor: Color = Color.init(red: 227/255, green: 182/255, blue: 72/255, opacity: 1)
    @State var secondColor: Color = Color.init(red: 222/255, green: 122/255, blue: 42/255, opacity: 1)
    
    let temps = [FutureTempHour(id: 1, hour: 1, temp: 69), FutureTempHour(id: 2, hour: 2, temp: 71), FutureTempHour(id: 3, hour: 3, temp: 72), FutureTempHour(id: 4, hour: 4, temp: 70), FutureTempHour(id: 5, hour: 5, temp: 66), FutureTempHour(id: 6, hour: 6, temp: 64), FutureTempHour(id: 7, hour: 7, temp: 63)]
    
    @State var temp: Int = 0
    @State var inFarenheight = true
    @State var fButtonPressed = false
    
    var body: some View {
        
        ScrollView {
            DetailHeader(fButtonPressed: $fButtonPressed, showingDetail: $showingDetail)
            CurrentTempDetail(beach: beach, temp: $temp)
            Divider().background(Color.white)
            SurfView(beach: beach)
            Divider().background(Color.white)
//            ShowInMapsButton()
//            Divider().background(Color.white)
            DetailMapView(beach: beach)
        }
        .background(LinearGradient.init(gradient: Gradient.init(colors: [firstColor, secondColor]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            
            getTempInt(str: beach.temp)

            switch beach.weather {
            case "Partly Cloudy":
                secondColor = Color.init(red: 240/255, green: 190/255, blue: 80/255, opacity: 1)
                firstColor = Color.init(red: 220/255, green: 140/255, blue: 150/255, opacity: 1)
            case "Light Rain":
                secondColor = Color.init(red: 57/255, green: 70/255, blue: 147/255, opacity: 1)
                firstColor = Color.init(red: 84/255, green: 128/255, blue: 195/255, opacity: 1)
            case "Overcast":
                secondColor = Color.init(red: 57/255, green: 70/255, blue: 147/255, opacity: 1)
                firstColor = Color.init(red: 84/255, green: 128/255, blue: 195/255, opacity: 1)
            case "A Few Clouds":
                secondColor = Color.init(red: 252/255, green: 234/255, blue: 180/255, opacity: 1)
                firstColor = Color.init(red: 225/255, green: 145/255, blue: 170/255, opacity: 1)
            case "Mostly Cloudy":
                firstColor = Color.init(red: 21/255, green: 153/255, blue: 87/255, opacity: 1)
                secondColor = Color.init(red: 21/255, green: 87/255, blue: 153/255, opacity: 1)
            case "Mostly Cloudy and Breezy":
                firstColor = Color.gray
            case "Fair":
                firstColor = Color.gray
            case "A Few Clouds and Breezy":
                firstColor = Color.gray
            case "Partly Cloudy and Breezy":
                firstColor = Color.gray
            default:
                print("We don't have a color in the Detail View for this")
            }
        })
    }
    
    func getTempInt(str: String) {
        
        guard let num = Int(str) else { return }
        self.temp = num
    }
    
    func convertTo(num: Int) {
        if self.inFarenheight {
            
            var celsius = Double(num - 32) / 1.8
            
            celsius.round()
//            guard let x = Int(celsius) else {
//                return
//            }
            self.temp = Int(celsius)
            
            inFarenheight.toggle()
        } else {
            var farenheight = (Double(num) * 1.8) + 32.0
            
            farenheight.round()
            
            self.temp = Int(farenheight)
            
            inFarenheight.toggle()
        }
    }
}

