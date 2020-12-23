//
//  Api.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 12/22/20.
//

import SwiftUI

struct BeachCondition: Decodable, Hashable {
    let beach, island, shore, lat, lon, nearshore, offshore, temp, weather, wind, surf: String
}

class Api {
    func getislandData(island: String, completion: @escaping ([BeachCondition]) -> ()) {
        print("initializing")
        let str = "https://hawaiibeachsafety.com/rest/conditions.json?island=\(island)"
        
        guard let url = URL(string: str) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(Array<BeachCondition>.self, from: data)
                    
                DispatchQueue.main.async {
                    completion(res)
                }
                
                
            } catch {
                print("Failure: \(error)")
            }
        }.resume()
    }
}
