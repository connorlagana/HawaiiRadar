//
//  DetailHeader.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/3/21.
//

import SwiftUI

struct DetailHeader: View {
    var size: CGFloat = 30
    
    var body: some View {
        HStack {
            Spacer()
            Text("Mon, July 6")
                .foregroundColor(.white)
                .font(Font.custom("Nunito-Bold", size: 18))
                .padding(.leading, size)
            Spacer()
            Text("°F")
                .foregroundColor(.white)
                .font(Font.custom("Nunito-Bold", size: 18))
                .frame(width: size, height: size, alignment: .leading)
        }.padding(20)
    }
}

struct DetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeader()
    }
}
