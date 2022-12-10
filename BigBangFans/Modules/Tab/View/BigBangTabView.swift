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
            MainView(viewModel: MainViewModel())
                .tabItem {
                    Label ("Seasons", systemImage: "atom")

                }
            GridView()
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
