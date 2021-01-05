//
//  SurfView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/5/21.
//

import SwiftUI

struct SurfView: View {
    
    var showDetail = true
    var beach: BeachCondition
    
    var body: some View {
        HStack {
            VStack {
                Image("wave2")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 55, height: 55, alignment: .center)
                    .scaleEffect(showDetail ? 1 : 0)
                    .animation(.spring())
                Text(beach.nearshore.capitalizingFirstLetter())
                    .foregroundColor(.white)
                    .font(Font.custom("Nunito-Regular", size: 18))
                    
            }
            .frame(width: 110, height: 100)
            
            Spacer()
            
            VStack {
                Image("surf")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 55, height: 55, alignment: .center)
                    .scaleEffect(showDetail ? 1 : 0)
                    .animation(.spring())
                Text(beach.surf)
                    .foregroundColor(.white)
                    .font(Font.custom("Nunito-Regular", size: 18))
                    
            }
            .frame(width: 110, height: 100)
            
            Spacer()
            
            VStack {
                Image("wind")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 55, height: 55, alignment: .center)
                    .scaleEffect(showDetail ? 1 : 0)
                    .animation(.spring())
                
                HStack {
                    Text(beach.wind.extractSpeedFromWind(str: beach.wind))
                        .foregroundColor(.white)
                        .font(Font.custom("Nunito-Regular", size: 18))
                    Image("arrow")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.white)
                        .rotationEffect(.degrees(Double(beach.wind.extractDirectionFromWind(str: beach.wind))))
                }
            }
            .frame(width: 110, height: 100)
        }.padding()
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    func extractSpeedFromWind(str: String) -> String {
        if str == "calm" {
            return "0 MPH"
        }
        
        else {
            let arr = str.split(separator: " ")
            print("init this bitch", arr)
            return ("\(arr[2]) MPH")
        }
    }
    
    func extractDirectionFromWind(str: String) -> Int {
        if str == "calm" {
            return 0
        }
        
        else {
            let arr = str.split(separator: " ")
            let direction = arr[0]
            
            switch direction {
            case "Northeast":
                return -45
            default:
                return 0
            }
            
        }
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
