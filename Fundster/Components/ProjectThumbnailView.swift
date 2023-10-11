//
//  ProjectThumbnailView.swift
//  Fundster
//
//  Created by Martin Novak on 11.10.2023..
//

import SwiftUI

struct ProjectThumbnailView: View {
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Tsunami_by_hokusai_19th_century.jpg/700px-Tsunami_by_hokusai_19th_century.jpg"),
                    content: { image in
                        image
                            .resizable()
                            .cornerRadius(20)
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 150, maxHeight: 250)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
            .cornerRadius(15)
            VStack {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    .frame(height: 50)
                ProgressBar()
                    HStack {
                        Image(systemName: "dollarsign.circle")
                        Text("40%")
                            .bold()
                        Spacer()
                        Image(systemName: "clock")
                        Text("40 days")
                            .bold()
                        Spacer()
                    }

            }
        }
        .padding(5)
        .frame(height: 150)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.gray.opacity(0.15), radius: 20, x: 0, y: 0)
    }
}

struct ProjectThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectThumbnailView()
    }
}
