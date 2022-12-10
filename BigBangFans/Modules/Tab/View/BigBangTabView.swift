//
//  BigBangTabView.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 10/12/22.
//

import SwiftUI

struct BigBangTabView: View {
    var body: some View {
        TabView {
            SeasonsView()
                .tabItem {
                    Label ("Seasons", systemImage: "atom")

                }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}

struct TabBigBangView_Previews: PreviewProvider {
    static var previews: some View {
        BigBangTabView()
    }
}
