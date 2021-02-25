//
//  CurrentTempDetail.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/3/21.
//

import SwiftUI

struct CurrentTempDetail: View {
    
    var beach: BeachCondition
    
    @State var showDetail = false
    
    @Binding var temp: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(beach.beach)
                        .foregroundColor(.white)
                        .font(Font.custom("Nunito-Bold", size: 14))
                        
                    Text("\(temp ?? 0)°")
                        .foregroundColor(.white)
                        .font(Font.custom("Nunito-Bold", size: 84))
                        .padding(.top, 20)
                }
                Spacer()
                
                VStack {
                    switch beach.weather {
                    case "Partly Cloudy":
                        Image("clouds-and-sun-big")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100, alignment: .trailing)
                            .scaleEffect(showDetail ? 1 : 0)
                            .animation(.spring())
                    case "Light Rain":
                        Image("rain-big")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100, alignment: .trailing)
                            .scaleEffect(showDetail ? 1 : 0)
                            .animation(.spring())
                    case "Overcast":
                        Image("rain-big")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100, alignment: .trailing)
                            .scaleEffect(showDetail ? 1 : 0)
                            .animation(.spring())
                    case "A Few Clouds":
                        Image("clouds-and-sun-big")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100, alignment: .trailing)
                            .scaleEffect(showDetail ? 1 : 0)
                            .animation(.spring())
                    case "Mostly Cloudy":
                        Image("cloud-big")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100, alignment: .trailing)
                            .scaleEffect(showDetail ? 1 : 0)
                            .animation(.spring())
                    case "Mostly Cloudy and Breezy":
                        Image("cloud-big")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100, alignment: .trailing)
                            .scaleEffect(showDetail ? 1 : 0)
                            .animation(.spring())
                    case "Fair":
                        Image("sun-big")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100, alignment: .trailing)
                            .scaleEffect(showDetail ? 1 : 0)
                            .animation(.spring())
                    case "A Few Clouds and Breezy":
                        Image("wind-big")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100, alignment: .trailing)
                            .scaleEffect(showDetail ? 1 : 0)
                            .animation(.spring())
                    case "Partly Cloudy and Breezy":
                        Image("wind-big")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100, alignment: .trailing)
                            .scaleEffect(showDetail ? 1 : 0)
                            .animation(.spring())
                    case "Mostly Cloudy with Haze":
                        Image("cloud-big")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100, alignment: .trailing)
                            .scaleEffect(showDetail ? 1 : 0)
                            .animation(.spring())
                    case "Fog/Mist and Breezy":
                        Image("wind-big")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100, alignment: .trailing)
                            .scaleEffect(showDetail ? 1 : 0)
                            .animation(.spring())
                    case "Rain and Breezy":
                        Image("rain-big")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100, alignment: .trailing)
                            .scaleEffect(showDetail ? 1 : 0)
                            .animation(.spring())
                    default:
                        Text(beach.weather)
                    }
                    
                    
                    
                }
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Text(beach.weather)
                    .foregroundColor(.white)
                    .font(Font.custom("Nunito-Regular", size: 20))
            }
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                showDetail = true
            }
            
            
            
        }
    }
    
    
}



