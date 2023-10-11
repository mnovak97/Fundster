//
//  BottomNavigationView.swift
//  Fundster
//
//  Created by Martin Novak on 10.10.2023..
//

import SwiftUI

struct BottomNavigationView: View {
    var body: some View {
        NavigationView {
            TabView {
                ExploreView()
                    .tabItem {
                        Image(systemName: "safari")
                    }
                ProjectsView()
                    .tabItem {
                        Image(systemName: "chart.bar.doc.horizontal.fill")
                    }
                FavouriteView()
                    .tabItem {
                        Image(systemName: "heart")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                    }
            }
            .accentColor(Color("Primary"))
        }
    }
}

struct BottomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationView()
    }
}
