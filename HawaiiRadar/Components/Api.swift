//
//  Api.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 12/22/20.
//

import SwiftUI

struct BeachItem: Decodable, Hashable {
    let beach, island, shore, lat, lon, nearshore, offshore, updated: String
}

struct BeachCondition: Decodable, Hashable {
    let beach, island, shore, lat, lon, nearshore, offshore, temp, weather, wind, surf, beach_id: String
}

struct CurrentWeather: Decodable, Hashable {
    let main: Main
    let wind: Wind
}

struct Main: Decodable, Hashable {
    let temp, feels_like, temp_min, temp_max, pressure, humidity, sea_level: Int
}

struct Wind: Decodable, Hashable {
    let speed, deg: Int
}

class Api {
    func getislandData(island: String, completion: @escaping ([BeachCondition]) -> ()) {
        print("initializing")
        let str = "https://hawaiibeachsafety.com/rest/conditions.json"
        
        guard let url = URL(string: str) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(Array<BeachCondition>.self, from: data)
                var newArr = [BeachCondition]()
                
                for beach in res {
                    if beach.island == island {
                        newArr.append(beach)
                    }
                }
                    
                DispatchQueue.main.async {
                    completion(newArr)
                }
                
                
            } catch {
                print("Failure: \(error)")
            }
        }.resume()
    }
    
    func getCurrentWeatherData(lat: Float, lon: Float, completion: @escaping (CurrentWeather) -> ()) {
        let apiKey = "847a6bd0c50c3095f8c13aa2a085e313"
        let str = "api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        
        guard let url = URL(string: str) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(CurrentWeather.self, from: data)
                    
                DispatchQueue.main.async {
                    completion(res)
                }
                
                
            } catch {
                print("Failure: \(error)")
            }
        }.resume()
    }
}
