//
//  EpisodesViewModel.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 8/12/22.
//

import Foundation

final class EpisodesViewModel: ObservableObject {
    var persistence = ModelPersistence()
    
    @Published var episodes: [Episode]
    @Published var favorites: Favorites {
        didSet {
            persistence.saveFavorite(favorites: favorites)
        }
    }
    
    var seasons: [Season] {
        Dictionary(grouping: episodes) { episode in
            episode.season
        }.values.sorted {
            $0.first?.season ?? 0 < $1.first?.season ?? 0
        }.map { Season(id: $0.first?.season ?? 0, episodes: $0) }
    }
    
    init() {
        episodes = persistence.fetchEpisodes()
        favorites = persistence.loadFavorite()
    }
    
    func isFavorite(_ id: Int) -> Bool {
        favorites.list.contains(where: { $0 == id })
    }
    
    func togleFavorite(id: Int) {
        if favorites.list.contains(where: { $0 == id }) {
            favorites.list.removeAll(where: { $0 == id })
        } else {
            favorites.list.append(id)
        }
    }
}
