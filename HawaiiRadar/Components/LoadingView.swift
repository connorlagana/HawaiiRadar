//
//  LoadingView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 12/22/20.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        LottieView(name: "rain")
            .frame(width: 200, height: 200)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
