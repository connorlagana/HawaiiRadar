//
//  IslandHeader.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/3/21.
//

import SwiftUI

struct IslandHeader: View {
    
    var beachToDisplay: String
    var buttonSize: CGFloat = 30.0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack(alignment: .bottom) {
            //Back button
            Button {
                presentationMode.wrappedValue.dismiss()
                print("dismissing")
            } label: {

                Image("back")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: buttonSize, height: buttonSize, alignment: .leading)
            }
            Spacer()
            Text(beachToDisplay)
                .foregroundColor(.white)
                .font(Font.custom("Nunito-Bold", size: 18))
//                    .frame(width: 100)
                .padding(.leading, -buttonSize)
            Spacer()
            
        }
//        .frame(height: 100)
    }
}

struct IslandHeader_Previews: PreviewProvider {
    static var previews: some View {
        IslandHeader(beachToDisplay: "Oahu")
    }
}
