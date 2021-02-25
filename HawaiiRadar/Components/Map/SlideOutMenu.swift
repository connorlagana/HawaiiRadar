//
//  SlideOutMenu.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/21/21.
//

import SwiftUI

struct SlideOutMenu: View {
    
    @Binding var isMenuShowing: Bool
    
    let islands: [String] = ["Big Island", "Maui", "Oahu", "Kauai"]
    
    var body: some View {
        HStack {
            ZStack {
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Text("Menu")
                            .foregroundColor(Color(.label))
                            .font(Font.custom("Nunito-Bold", size: 30))
                        Spacer()
                        Button {
                            isMenuShowing.toggle()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                    }.padding()
                    
                    VStack {
                        ForEach(islands, id: \.self) { island in
                            
                                
                            NavigationLink(
                                destination: IslandView(beachToDisplay: island),
                //                    .ignoresSafeArea(edges: .all),
                                label: {
                                    VStack {
                                        Text(island)
                                            .foregroundColor(Color(.label))
                                            .font(Font.custom("Nunito-Regular", size: 24))
                                        
                                        Divider().background(Color(.label))
                                    }.frame(height: 60, alignment: .center)
                                })
                                
                            
                        }
                    }
                    
                    Spacer()
                }
                
                
            }
            .frame(width: 200)
            Spacer()
        }
        .gesture(DragGesture(minimumDistance: 50).onEnded({ (_) in
            self.isMenuShowing.toggle()
        }))
        .offset(x: self.isMenuShowing ? 0 : -200)
        .animation(.easeInOut)
    }
}
