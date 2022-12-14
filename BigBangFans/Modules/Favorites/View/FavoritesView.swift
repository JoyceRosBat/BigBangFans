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
                            NavigationLink(value: episode) {
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
                }
                .padding()
            }
            .navigationDestination(for: Episode.self) { episode in
                DetailsView(viewModel: DetailsViewModel(episode: episode))
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Favorites")
        }
    }
}

extension FavoritesView {
    func cover(of episode: Episode) -> some View {
        ZStack(alignment: .topLeading) {
            Image("\(episode.image)")
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
            
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20)
                .foregroundColor(.yellow.opacity(0.7))
                .shadow(color: .black, radius: 0.3)
                .padding(.leading, 5)
                .padding(.top, 5)
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FavoritesView()
                .environmentObject(EpisodesViewModel())
        }
    }
}
