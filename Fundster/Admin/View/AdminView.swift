//
//  AdminView.swift
//  Fundster
//
//  Created by Martin Novak on 10.11.2023..
//

import SwiftUI

struct AdminView: View {
    @ObservedObject var viewModel = AdminViewModel()
    var body: some View {
        VStack {
            List {
                Section(header: Text("Users")) {
                    ForEach(viewModel.users) { user in
                        ProfileThumbnailView(user: user)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            List {
                Section(header: Text("Projects")) {
                    ForEach(viewModel.projects) { project in
                        Text(project.name!)
                            .swipeActions {
                                Button("Delete") {
                                    viewModel.deleteProject(project: project)
                                }.tint(Color("Primary"))
                            }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchUsers()
            viewModel.fetchProjects()
        }
    }
}

#Preview {
    AdminView()
}
