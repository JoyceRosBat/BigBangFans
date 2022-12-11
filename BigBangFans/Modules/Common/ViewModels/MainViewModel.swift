//
//  EpisodesViewModel.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 8/12/22.
//

import Foundation

final class EpisodesViewModel: ObservableObject {
    var persistence = ModelPersistence()
    
    @Published var searchText: String = ""
    @Published var episodes: [Episode]
    @Published var checks: EpisodesCheck {
        didSet {
            persistence.saveChecks(checks: checks)
        }
    }
    
    var filteredEpisodes: [Episode] {
        searchText.isEmpty ? episodes : episodes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var seasons: [Season] {
        Dictionary(grouping: filteredEpisodes) { episode in
            episode.season
        }.values.sorted {
            $0.first?.season ?? 0 < $1.first?.season ?? 0
        }.map { Season(id: $0.first?.season ?? 0, episodes: $0) }
    }
    
    init() {
        episodes = persistence.fetchEpisodes()
        checks = persistence.loadChecks()
    }
    
    func isFavorite(_ id: Int) -> Bool {
        checks.favorites.contains(where: { $0 == id })
    }
    
    func togleFavorite(id: Int) {
        if checks.favorites.contains(where: { $0 == id }) {
            checks.favorites.removeAll(where: { $0 == id })
        } else {
            checks.favorites.append(id)
        }
    }
    
    func isSeen(_ id: Int) -> Bool {
        checks.seen.contains(where: { $0 == id })
    }
    
    func togleSeen(id: Int) {
        if checks.seen.contains(where: { $0 == id }) {
            checks.seen.removeAll(where: { $0 == id })
            guard let episode = episodes.first(where: { $0.id == id }) else { return }
            if isSeasonSeen(episode.season) {
                togleSeasonSeen(id: episode.season)
            }
        } else {
            checks.seen.append(id)
            guard let episode = episodes.first(where: { $0.id == id }),
            let season = seasons.first(where: { $0.id == episode.season }) else { return }
            if !isSeasonSeen(season.id) {
                let ids = season.episodes.map { $0.id }
                let intersection = Array(Set(checks.seen).intersection(ids))
                if intersection.count == season.episodes.count {
                    togleSeasonSeen(id: season.id)
                }
            }
        }
    }
    
    func isSeasonSeen(_ id: Int) -> Bool {
        checks.seasonSeen.contains(where: { $0 == id })
    }
    
    func togleSeasonSeen(id: Int, updateEpisodes: Bool = false) {
        if checks.seasonSeen.contains(where: { $0 == id }) {
            checks.seasonSeen.removeAll(where: { $0 == id })
            if updateEpisodes {
                checkUnseenAllEpisodes(seasonId: id)
            }
        } else {
            checks.seasonSeen.append(id)
            if updateEpisodes {
                checkSeenAllEpisodes(seasonId: id)
            }
        }
    }
    
    func checkSeenAllEpisodes(seasonId: Int) {
        guard let episodes = seasons.first(where: { $0.id == seasonId })?.episodes else { return }
        checks.seen.append(contentsOf: episodes.map { $0.id })
    }

    func checkUnseenAllEpisodes(seasonId: Int) {
        guard let episodes = seasons.first(where: { $0.id == seasonId })?.episodes else { return }
        let ids =  episodes.map { $0.id }
        checks.seen.removeAll(where: { ids.contains($0) })
    }
    
    func episode(by id: Int) -> Episode? {
        episodes.first(where: { $0.id == id })
    }
}
