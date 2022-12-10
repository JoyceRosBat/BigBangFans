//
//  Season.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 8/12/22.
//

import Foundation

struct Season: Identifiable {
    let id: Int
    let episodes: [Episode]
    
    static var test: Season {
        Season(id: 1, episodes: [.test])
    }
}
