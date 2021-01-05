//
//  DetailHScroll.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/3/21.
//

import SwiftUI

struct DetailHScroll: View {
    
    @State var hourTemps: [FutureTempHour]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(hourTemps, id: \.self) { temp in
                    
                    VStack(spacing: 10) {
                        switch temp.id {
                        case 0:
                            Text("Now")
                                .foregroundColor(Color.white.opacity(0.6))
                                .font(Font.custom("Nunito-Regular", size: 14))
                        default:
                            Text("\(temp.hour) pm")
                                .foregroundColor(Color.white.opacity(0.6))
                                .font(Font.custom("Nunito-Regular", size: 14))
                        }
                        Text("\(temp.temp)°")
                            .foregroundColor(.white)
                            .font(Font.custom("Nunito-Regular", size: 18))
                    }.frame(width: 70, height: 70, alignment: .center)
                    
                }
            }
            
        }
        .onAppear {
            addNow(temp: 69)
        }
        .frame(height: 100)
    }
    
    func addNow(temp: Int) {
        var newArr: [FutureTempHour] = []
        
        newArr.append(FutureTempHour.init(id: 0, hour: 0, temp: temp))
        for i in hourTemps {
            newArr.append(i)
        }
        
        hourTemps = newArr
    }
}

struct FutureTempHour: Identifiable, Hashable {
    var id, hour, temp: Int
}
