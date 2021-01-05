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
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(beach.beach)
                        .foregroundColor(.white)
                        .font(Font.custom("Nunito-Bold", size: 14))
                        
                    Text("\(beach.temp)°")
                        .foregroundColor(.white)
                        .font(Font.custom("Nunito-Bold", size: 84))
                        .padding(.top, 20)
                        
                    //Cant make API request for some reason idk
                    
//                    HStack {
//                        HStack {
//                            Image("back")
//                                .renderingMode(.template)
//                                .resizable()
//                                .frame(width: 15, height: 15)
//                                .foregroundColor(Color.white.opacity(0.5))
//                                .rotationEffect(.degrees(90))
//
//                            Text("74°")
//                                .foregroundColor(.white)
//                                .font(Font.custom("Nunito-Regular", size: 14))
//                        }
//
//                        HStack {
//                            Image("back")
//                                .renderingMode(.template)
//                                .resizable()
//                                .frame(width: 15, height: 15)
//                                .foregroundColor(Color.white.opacity(0.5))
//                                .rotationEffect(.degrees(-90))
//                            Text("56°")
//                                .foregroundColor(.white)
//                                .font(Font.custom("Nunito-Regular", size: 14))
//                        }
//                    }.frame(width: 100, height: 30)
                }
                Spacer()
    //            LottieView(name: "sunny")
    //                .frame(width: 200, height: 100, alignment: .trailing)
                VStack {
                    Image("sun-big")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100, alignment: .trailing)
                        .scaleEffect(showDetail ? 1 : 0)
                        .animation(.spring())
                    
                }
                
                Spacer()
            }
            
            //Cant make API request for weather for some reason idk
            
            VStack(alignment: .leading) {
                Text(beach.weather)
                    .foregroundColor(.white)
                    .font(Font.custom("Nunito-Regular", size: 20))
//                Text("Feels like 68°")
//                    .foregroundColor(Color.white.opacity(0.7))
//                    .font(Font.custom("Nunito-Regular", size: 14))
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



