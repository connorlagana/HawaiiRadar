//
//  IslandView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 12/22/20.
//

import SwiftUI

struct TestView: View {
    var beachesToDisplay = [BeachItem]()
    @State var showingDetail = false
    
    var body: some View {
        
        NavigationView {
                
            ScrollView {
                ForEach(["Sunset Beach", "Bellows Field Beach", "Ehukai Beach", "Aliʻi Beach Park", "Hanauma Bay", "Kailua Beach", "Flat Island", "Mokulua Islands", "Waikiki - Kapiolani Park"], id: \.self) { beach in
                    
                    NavigationLink(
                        destination: DetailView(beach: beach),
                        label: {
                            HStack {
                                Text(beach)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        })
                        .padding()
                        .frame(height: 75, alignment: .center)
                        .background(Color.gray)

                    
                    
                    
                }
            }
            .navigationBarTitle("O'ahu")
        }
        
    }
}

struct IslandView: View {
    
    @State var showingDetail = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("O'ahu")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                
                ForEach(["Sunset Beach", "Bellows Field Beach", "Ehukai Beach", "Aliʻi Beach Park"], id: \.self) { beach in
                    
                    Button(action: {
                        self.showingDetail.toggle()
                    }, label: {
                        HStack {
                            Text(beach)
                                .foregroundColor(.black)
                                Spacer()
                        }
                    }).sheet(isPresented: $showingDetail, content: {
                        DetailView(beach: beach)
                    })
                    .padding()
                    .frame(height: 75, alignment: .center)
                    .background(Color.gray)
                    
                    
                    
                }
            }
//            .background(Color.red)
        }
    }
}

struct DetailView: View {
    var beach: String
    var body: some View {
        Text(beach)
    }
}

struct IslandView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
