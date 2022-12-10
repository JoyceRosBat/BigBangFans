//
//  DetailsViewModel.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 10/12/22.
//

import Foundation

final class DetailsViewModel: ObservableObject {
    var persistence = ModelPersistence()
    @Published var data: EpisodesData {
        didSet {
            persistence.saveEpisodes(data: data)
        }
    }
    
    @Published var notes: String = ""
    @Published var rating: Int = 0
    
    var episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
        data = persistence.loadEpisodesData()
        rating = data.rating.first(where: { $0.key == episode.id })?.value ?? 0
        notes = data.notes.first(where: { $0.key == episode.id })?.value ?? ""
    }
    
    func save() {
        data.rating.updateValue(rating, forKey: episode.id)
        data.notes.updateValue(notes, forKey: episode.id)
    }
}
