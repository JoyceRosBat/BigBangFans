//
//  MainViewModel.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 8/12/22.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var episodes: [Episode]
    var persistence = ModelPersistence()
    
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
}
