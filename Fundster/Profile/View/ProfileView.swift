//
//  ProfileView.swift
//  Fundster
//
//  Created by Martin Novak on 10.10.2023..
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authVM : AuthViewModel
    var body: some View {
        VStack{
            Button {
                authVM.logout()
            } label: {
                Text("Log out")
            }

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
