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
                ForEach(viewModel.users.filter { $0.projects != nil && !$0.projects!.isEmpty }) { user in
                    Section(header: Text(user.name ?? "")) {
                        ForEach(user.projects ?? []) { project in
                            AdminProjectThumbnailView(project: project)
                            
                        }
                        .onDelete(perform: { indexSet in
                            guard let index = indexSet.first else {return}
                            viewModel.deleteProject(user: user, projectIndex: index)
                        })
                    }
                }
            }
            .scrollIndicators(.hidden)
            
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

#Preview {
    AdminView()
}
