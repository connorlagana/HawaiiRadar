//
//  IslandView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 12/22/20.
//

import SwiftUI

struct BeachCondition: Decodable {
    let beach, island, shore, lat, lon, nearshore, offshore, temp, weather, wind, surf: String
}

class IslandViewModel {
    
    init() {
        getislandData(island: "oahu")
    }
    
    func getislandData(island: String) {
        let str = "https://hawaiibeachsafety.com/rest/conditions.json?island=\(island)"
        
        guard let url = URL(string: str) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(Array<BeachCondition>.self, from: data)
                
                    //Step 1: Fetch API data and store in Beach Items Array
                print("BeachCondition1: \(res[0])")
                    
                DispatchQueue.main.async {
                    
                    //Put shit here
                    
                }
                
            } catch {
                print("Failure: \(error)")
            }
        }.resume()
    }
}

struct TestView: View {
    var beachToDisplay: String
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
    var beach: String
    var body: some View {
        Text(beach)
    }
}

struct IslandView_Previews: PreviewProvider {
    static var previews: some View {
        IslandView()
    }
}
