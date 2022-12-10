//
//  BigBangFansApp.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 8/12/22.
//

import SwiftUI

@main
struct BigBangFansApp: App {
    @StateObject var viewModel = EpisodesViewModel()
    
    var body: some Scene {
        WindowGroup {
            BigBangTabView()
                .environmentObject(viewModel)
        }
    }
}
