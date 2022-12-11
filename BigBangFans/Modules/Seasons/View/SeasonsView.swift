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
                                    .swipeActions(edge: .trailing,
                                                  allowsFullSwipe: true) {
                                        Button {
                                            viewModel.togleFavorite(id: episode.id)
                                        } label: {
                                            viewModel.isFavorite(episode.id) ? Image(systemName: "star.fill")
                                            : Image(systemName: "star")
                                        }
                                        .tint(viewModel.isFavorite(episode.id) ? .yellow : .gray)
                                    }
                                    .swipeActions(edge: .leading,
                                                  allowsFullSwipe: true) {
                                        
                                        Button {
                                            viewModel.togleSeen(id: episode.id)
                                        } label: {
                                            viewModel.isSeen(episode.id) ? Image(systemName: "eye.slash")
                                            : Image(systemName: "eye")
                                        }
                                        .tint(viewModel.isSeen(episode.id) ? .cyan : .gray)
                                    }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Episode.self) { episode in
                DetailsView(viewModel: DetailsViewModel(episode: episode))
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
                .frame(width: 140)
                .cornerRadius(10)
            
            Text("Season \(id)")
                .font(.title2)
            
            Button {
                viewModel.togleSeasonSeen(id: id, updateEpisodes: true)
            } label: {
                viewModel.isSeasonSeen(id) ? Image(systemName: "eye.slash")
                : Image(systemName: "eye")
            }
            .tint(viewModel.isSeasonSeen(id) ? .cyan : .gray)
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
            
            if viewModel.isSeen(episode.id) {
                Image(systemName: "eye.slash")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.gray.opacity(0.5))
                    .scaledToFit()
                    .frame(width: 15)
            }
            
            if viewModel.isFavorite(episode.id) {
                Image(systemName: "star.fill")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.gray.opacity(0.4))
                    .scaledToFit()
                    .frame(width: 15)
            }
        }
    }
}

struct SeasonsView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonsView()
            .environmentObject(EpisodesViewModel())
    }
}
