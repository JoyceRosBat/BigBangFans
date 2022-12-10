//
//  Episode.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 8/12/22.
//

import Foundation

struct Episode: Codable, Identifiable, Hashable {
    let id: Int
    let url: URL
    let name: String
    let season, number: Int
    let airdate: String
    let runtime: Int
    let image: String
    let summary: String
    
    static var test: Episode {
        Episode(id: 2913, url: URL(string: "https://www.tvmaze.com/episodes/2913/the-big-bang-theory-1x01-pilot")!, name: "Pilot", season: 1, number: 1, airdate: "2007-09-24", runtime: 30, image: "12368", summary: "Is a comedy about brilliant physicists, Leonard and Sheldon, who are the kind of \"beautiful minds\" that understand how the universe works. But none of that genius helps them interact with people, especially women. All this begins to change when a free-spirited beauty named Penny moves in next door. Sheldon, Leonard's roommate, is quite content spending his nights playing Klingon Boggle with their socially dysfunctional friends, fellow Cal Tech scientists Wolowitz and Koothrappali. However, Leonard sees in Penny a whole new universe of possibilities... including love.\n")
    }
}

struct Favorites: Codable {
    var list: [Int]
}

struct EpisodesData {
    var rating: [(id: Int, rating: Int)]
    var notes: [(id: Int, notes: String)]
}
