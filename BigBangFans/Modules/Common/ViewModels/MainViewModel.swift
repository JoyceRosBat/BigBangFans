//
//  EpisodesViewModel.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 8/12/22.
//

import Foundation

final class EpisodesViewModel: ObservableObject {
    @Published var episodes: [Episode]
    var persistence = ModelPersistence()
    var favorites: [Int] = []
    
    var seasons: [Season] {
        Dictionary(grouping: episodes) { episode in
            episode.season
        }.values.sorted {
            $0.first?.season ?? 0 < $1.first?.season ?? 0
        }.map { Season(id: $0.first?.season ?? 0, episodes: $0) }
    }
    
    init() {
        episodes = persistence.fetchEpisodes()
    }
    
    func isFavorite(_ id: Int) -> Bool {
        favorites.contains(where: { $0 == id })
    }
    
    func togleFavorite(id: Int) {
        if favorites.contains(where: { $0 == id }) {
            favorites.removeAll(where: { $0 == id })
        } else {
            favorites.append(id)
        }
    }
}
