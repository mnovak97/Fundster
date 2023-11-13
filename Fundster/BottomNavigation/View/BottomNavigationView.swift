//
//  BottomNavigationView.swift
//  Fundster
//
//  Created by Martin Novak on 10.10.2023..
//

import SwiftUI

struct BottomNavigationView: View {
    @EnvironmentObject var authVM: AuthViewModel
    var body: some View {
        NavigationStack {
            TabView {
                    ExploreView()
                        .tabItem {
                            Image(systemName: "safari")
                        }
                    ProjectsView()
                        .tabItem {
                            Image(systemName: "chart.bar.doc.horizontal.fill")
                        }
                if authVM.currentUser?.role == Role.ADMIN {
                    AdminView()
                        .tabItem {
                            Image(systemName: "person.badge.key")
                        }
                }
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.crop.circle")
                        }
                }
        }
        .accentColor(Color("Primary"))
    }
}

struct BottomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationView()
    }
}
