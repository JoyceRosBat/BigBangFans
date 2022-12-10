//
//  ModelPersistence.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 8/12/22.
//

import Foundation

extension URL {
    static let bigBangDataURL = Bundle.main.url(forResource: "BigBang", withExtension: "json")!
    static let favoritesURL = URL.documentsDirectory.appending(component: "favorites").appendingPathExtension("json")
    static let episodesDataUrl = URL.documentsDirectory.appending(component: "episodesData").appendingPathExtension("json")
}

final class ModelPersistence {
    func fetchEpisodes(url: URL = .bigBangDataURL) -> [Episode] {
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Episode].self, from: data)
        } catch {
            print("Error en la carga \(error)")
            return []
        }
    }
    
    func loadFavorite() -> Favorites {
        do {
            let data = try Data(contentsOf: .favoritesURL)
            return try JSONDecoder().decode(Favorites.self, from: data)
        } catch {
            print("Error en la carga: \(error)")
            return Favorites(list: [])
        }
    }
    
    func saveFavorite(favorites: Favorites) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(favorites)
            try data.write(to: .favoritesURL, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error al guardar el archivo: \(error)")
        }
    }
    
    func loadEpisodesData() -> EpisodesData {
        do {
            let data = try Data(contentsOf: .episodesDataUrl)
            return try JSONDecoder().decode(EpisodesData.self, from: data)
        } catch {
            print("Error en la carga: \(error)")
            return EpisodesData(rating: [:], notes: [:])
        }
    }
    
    func saveEpisodes(data: EpisodesData) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(data)
            try data.write(to: .episodesDataUrl, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error al guardar el archivo: \(error)")
        }
    }
}
