//
//  BeachSquareView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/4/21.
//

import SwiftUI

struct BeachSquareView: View {
    var beach: BeachCondition
    
    @State var showingDetail = false
    
    
    var body: some View {
        Button {
            self.showingDetail.toggle()
        } label: {
            VStack(alignment: .leading) {
                HStack {
                    Text(beach.temp)
                        .foregroundColor(.white)
                        .font(Font.custom("Nunito-Bold", size: 28))
                    Spacer()
                    switch beach.weather {
                    case "Partly Cloudy":
                        Image("clouds-and-sun")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    case "Light Rain":
                        Image("rain")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    case "Overcast":
                        Image("rain")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    case "A Few Clouds":
                        Image("clouds-and-sun")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    case "Mostly Cloudy":
                        Image("cloud")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    case "Mostly Cloudy and Breezy":
                        Image("cloud")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    case "Fair":
                        Image("sun")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    case "A Few Clouds and Breezy":
                        Image("wind")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    case "Partly Cloudy and Breezy":
                        Image("wind")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    case "Mostly Cloudy with Haze":
                        Image("cloud")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    default:
                        Text(beach.weather)
                    }
//                                Text(beach.weather)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("\(beach.beach),")
                        .foregroundColor(.white)
                        .font(Font.custom("Nunito-Bold", size: 18))
                    Text(beach.island)
                        .foregroundColor(Color.init(red: 180/255, green: 180/255, blue: 190/255, opacity: 1))
                        .font(Font.custom("Nunito-Light", size: 14))
                }
            }
            .sheet(isPresented: $showingDetail, content: {
                DetailView(beach: beach)
            })
            .frame(width: 150, height: 150, alignment: .center)
            .padding(.all, 10)
            .background(Color.black.opacity(0.2))
            .cornerRadius(14)
        }
    }
}
