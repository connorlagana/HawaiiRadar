//
//  ShowInMapsButton.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 2/25/21.
//

import SwiftUI

struct ShowInMapsButton: View {
    
    @State private var showingActionSheet = false
    
    var body: some View {
        Button {
            showingActionSheet.toggle()
        } label: {
            Text("Show In Maps")
                .foregroundColor(Color.white)
        }.actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Open in Maps"), message: Text("Select an app to open"), buttons: [.default(Text("Apple Maps"), action: {
                UIApplication.shared.openURL(NSURL(string: "http://maps.apple.com/?address=1600,PennsylvaniaAve.,20500")! as URL)
            }), .default(Text("Google Maps"), action: {
                UIApplication.shared.openURL(NSURL(string: "http://maps.apple.com/?address=87,TowerMountainDr.,07924")! as URL)
            })])
        }

        
    }
}

struct ShowInMapsButton_Previews: PreviewProvider {
    static var previews: some View {
        ShowInMapsButton()
    }
}
