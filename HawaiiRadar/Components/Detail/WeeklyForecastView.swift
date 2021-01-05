//
//  WeeklyForecastView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/3/21.
//

import SwiftUI

struct WeeklyForecastView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WeeklyForecast: Identifiable, Hashable {
    let id, high, low: Int
}
