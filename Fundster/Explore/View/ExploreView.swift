//
//  ExploreView.swift
//  Fundster
//
//  Created by Martin Novak on 10.10.2023..
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText: String = ""
    var body: some View {
        VStack {
            CustomSearch(text: $searchText)
            Spacer()
            ScrollView {
                LazyVStack {
                    ProjectThumbnailView()
                    ProjectThumbnailView()
                    ProjectThumbnailView()
                    ProjectThumbnailView()
                    ProjectThumbnailView()
                }
            }
        }
        .padding()
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
