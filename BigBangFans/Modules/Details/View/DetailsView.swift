//
//  DetailsView.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 9/12/22.
//

import SwiftUI

struct DetailsView: View {
    var episode: Episode
    
    var body: some View {
        ScrollView{
            VStack {
                Spacer(minLength: 16)
                
                Image(episode.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
                Spacer(minLength: 32)
                
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
            Spacer()
        }
        .padding()
        .navigationTitle("Episode \(episode.number) - \(episode.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(episode: .test)
    }
}
