//
//  IslandView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 12/22/20.
//

import SwiftUI

struct TestView: View {
    var beachToDisplay: String
    @State var showingDetail = false
    @State var beachConditions = [BeachCondition]()
    
    var body: some View {
        
        NavigationView {
                
            ScrollView {
                ForEach(beachConditions, id: \.self) { beach in
                    
                    NavigationLink(
                        destination: DetailView(beach: beach),
                        label: {
                            HStack {
                                Text(beach.beach)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        })
                        .padding()
                        .frame(height: 75, alignment: .center)
                        .background(Color.gray)

                    
                    
                    
                }
            }
            .onAppear(perform: {
                Api().getislandData(island: beachToDisplay) { (posts) in
                    self.beachConditions = posts
                    
                }
            })
            .navigationBarTitle(beachToDisplay)
        }
        
    }
}

struct IslandView: View {
    
    @State var showingDetail = false
    
    var body: some View {
        Button(action: {
            self.showingDetail.toggle()
        }, label: {
            Text("Button")
        }).sheet(isPresented: $showingDetail, content: {
            TestView(beachToDisplay: "Oahu")
        })
    }
}

struct DetailView: View {
    var beach: BeachCondition
    
    var body: some View {
        ScrollView {
            VStack {
                Text(beach.beach).font(.title)
                HStack {
                    Text(beach.temp)
                    switch beach.weather {
                    case "Fair": LottieView(name: "sunny").frame(width: 100, height: 100)
                    case "Overcast": LottieView(name: "rain").frame(width: 100, height: 100)
                    default:
                        Text("q")
                    }
                }
            }
        }
    }
}

struct IslandView_Previews: PreviewProvider {
    static var previews: some View {
        IslandView()
    }
}
