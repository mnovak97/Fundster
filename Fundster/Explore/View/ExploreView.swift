//
//  ExploreView.swift
//  Fundster
//
//  Created by Martin Novak on 10.10.2023..
//

import SwiftUI

struct ExploreView: View {
    @ObservedObject var viewModel = ExploreViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                CustomSearch(text: $viewModel.searchText)
                Spacer()
                List {
                    ForEach(viewModel.searchableProjects) { project in
                        ZStack(alignment: .leading) {
                            NavigationLink(
                                destination: ProjectDetailsView(viewModel: ProjectDetailViewModel(project: project))) {
                                    EmptyView()
                                }
                                .opacity(0)
                            ProjectThumbnailView(project: project)
                                .foregroundColor(.black)
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                        
                    }
                }
                .listStyle(PlainListStyle())
                .scrollIndicators(.hidden)
                .refreshable {
                    viewModel.clearProjects()
                    viewModel.fetchProjects()
                }
            }
            .onAppear {
                viewModel.fetchProjects()
            }
            .padding()
        }
        .accentColor(Color("Primary"))
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
