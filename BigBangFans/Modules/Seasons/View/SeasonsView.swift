//
//  MainView.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 8/12/22.
//

import SwiftUI

struct SeasonsView: View {
    @EnvironmentObject var viewModel: EpisodesViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.seasons) { season in
                    ExpandableView {
                        header(with: season.id)
                    } content: {
                        ForEach(season.episodes) { episode in
                            NavigationLink(value: episode) {
                                content(with: episode)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Episode.self) { episode in
                DetailsView(episode: episode)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("The Big Bang Theory")
        }
    }
}

private extension SeasonsView {
    func header(with id: Int) -> some View {
        HStack {
            Image("season\(id)")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .cornerRadius(10)
            
            Text("Season \(id)")
                .font(.title2)
        }
    }
    
    func content(with episode: Episode) -> some View {
        HStack {
            Image(episode.image)
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .cornerRadius(10)
            
            Text("Episode \(episode.number) - \(episode.name)")
                .font(.body)
            
            Spacer()
        }
    }
}

struct SeasonsView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonsView()
            .environmentObject(EpisodesViewModel())
    }
}
