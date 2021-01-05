//
//  IslandScrollView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/3/21.
//

import SwiftUI

struct IslandScrollView: View {
    
    var beachConditions: [BeachCondition]
    
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 100, maximum: 200), spacing: 12),
                GridItem(.flexible(minimum: 100, maximum: 200))
            ], spacing: 12, content: {
                ForEach(beachConditions, id: \.self) { beach in
                    
                    BeachSquareView(beach: beach)
                    
                }
            })
            
        }
    }
}
