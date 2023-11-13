//
//  ContentView.swift
//  Fundster
//
//  Created by Martin Novak on 10.10.2023..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        BottomNavigationView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthViewModel())
    }
}
