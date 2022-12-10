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
        Text(episode.name)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(episode: .test)
    }
}
