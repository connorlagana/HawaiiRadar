//
//  MenuButton.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/21/21.
//

import SwiftUI

struct MenuButton: View {
    
    @Binding var isMenuShowing: Bool
    
    var body: some View {
        HStack {
            VStack {
                Button(action: {
                    self.isMenuShowing.toggle()
                }, label: {
                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                })
                
                Spacer()
            }
            Spacer()
        }.padding()
    }
}
