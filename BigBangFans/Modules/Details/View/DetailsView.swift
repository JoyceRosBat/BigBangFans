//
//  DetailsView.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 9/12/22.
//

import SwiftUI

struct DetailsView: View {
    var episode: Episode
    @State var text = ""
    
    var body: some View {
        VStack {
            Spacer(minLength: 16)
            
            Image(episode.image)
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .cornerRadius(10)
                .shadow(radius: 10)
            
            Spacer(minLength: 32)
            
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Text("Season:")
                            Text("\(episode.season)")
                        }
                        
                        Spacer(minLength: 16)
                        
                        Text("Title:")
                            .font(.headline)
                        Text("\(episode.number) - \(episode.name)")
                        
                        Spacer(minLength: 16)
                        Text("Summary:")
                            .font(.headline)
                        Text("\(episode.summary)")
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Rating:")
                        .font(.headline)
                    HStack {
                        Image(systemName: "star")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background {
                    Rectangle()
                        .fill(.black.opacity(0.1))
                        .cornerRadius(10)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Notes:")
                        .font(.headline)
                    HStack(alignment: .top) {
                        Image(systemName: "book")
                        
                        TextField("Notes", text: $text, axis: .vertical)
                            .lineLimit(8, reservesSpace: true)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                .padding()
                .background {
                    Rectangle()
                        .fill(.black.opacity(0.1))
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
        .padding()
        .navigationTitle("Episode \(episode.number) - \(episode.name)")
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(episode: .test)
    }
}
