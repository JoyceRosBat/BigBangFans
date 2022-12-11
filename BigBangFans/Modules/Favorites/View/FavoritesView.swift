//
//  FavoritesView.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 10/12/22.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: EpisodesViewModel
    
    var body: some View {
        if viewModel.checks.favorites.isEmpty {
            Text("Add favorite episodes by *swiping*\nto the left in the episodes list")
                .multilineTextAlignment(.center)
                .bold()
        } else {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]){
                    ForEach(viewModel.checks.favorites, id: \.self) { favoriteId in
                        if let episode = viewModel.episode(by: favoriteId) {
                            cover(of: episode)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        withAnimation { viewModel.togleFavorite(id: favoriteId) }
                                    } label: {
                                        Label("Remove from favorites", systemImage: "trash")
                                    }
                                    
                                }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

extension FavoritesView {
    func cover(of episode: Episode) -> some View {
        Image("\(episode.image)")
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(EpisodesViewModel())
    }
}
