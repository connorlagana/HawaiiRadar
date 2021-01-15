//
//  MapButtonView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/11/21.
//

import SwiftUI

struct MapButtonView: View {
    var beach: BeachCondition
    
    @State var showingDetail = false
    
    var body: some View {
        Button(action: {
            showingDetail.toggle()
            print("Hello world: ", beach)
        }, label: {
            VStack {
                Text(beach.beach)
                    .foregroundColor(.black)
                    .font(Font.custom("Nunito-Bold", size: 18))
                Text(beach.island)
                    .foregroundColor(Color.init(red: 20/255, green: 20/255, blue: 20/255, opacity: 1))
                    .font(Font.custom("Nunito-Regular", size: 18))
            }
        })
        .frame(width: 180, height: 100)
        .background(Color.white)
        .cornerRadius(10)
        .sheet(isPresented: $showingDetail, content: {
            DetailView(beach: beach)
        })
    }
}
