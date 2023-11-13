//
//  ProjectsView.swift
//  Fundster
//
//  Created by Martin Novak on 01.11.2023..
//

import SwiftUI

struct ProjectsView: View {
    @ObservedObject var viewModel = ProjectsViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    NavigationLink {
                        CreateProjectView()
                    } label: {
                        Text("Add project")
                            .padding()
                            .bold()
                            .frame(height: 30)
                            .background(Color("Primary"))
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                List {
                    ForEach(viewModel.userProjects) { project in
                        ZStack(alignment: .leading) {
                            NavigationLink(
                                destination: ProjectDetailsView(viewModel: ProjectDetailViewModel(project: project))) {
                                    EmptyView()
                                }
                                .opacity(0)
                            ProjectCard(project: project)
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
                    viewModel.fetchUserProjects()
                }
            }.onAppear {
                viewModel.fetchUserProjects()
            }
            .padding()
        }
        .accentColor(Color("Primary"))
    }
}

#Preview {
    ProjectsView()
}
