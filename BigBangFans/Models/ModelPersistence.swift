//
//  ModelPersistence.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 8/12/22.
//

import Foundation

extension URL {
    static let bigBangDataURL = Bundle.main.url(forResource: "BigBang", withExtension: "json")!
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
    
}
