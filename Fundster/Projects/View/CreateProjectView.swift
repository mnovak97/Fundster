//
//  ProjectsView.swift
//  Fundster
//
//  Created by Martin Novak on 10.10.2023..
//

import SwiftUI
import PhotosUI

struct CreateProjectView: View {
    @State private var viewModel = ProjectUploadViewModel()
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    @State private var projectPictureItem: PhotosPickerItem?
    @State private var projectImage: Image?
    @State private var projectUIImgae: UIImage?
    @State private var projectName = ""
    @State private var projectDescription = ""
    @State private var projectDeadline = Date.now
    @State private var projectMoneyGoal = 0
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
        VStack(spacing: 15) {
            PhotosPicker(selection: $projectPictureItem, matching: .images) {
                if let projectImage {
                    projectImage
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(width: 300, height: 250)
                    
                    
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .foregroundStyle(Color("Primary"))
                        .frame(width: 300,height: 250)
                }
            }
            
            HStack {
                Text("Project name:")
                TextField("Enter project name", text: $projectName)
                    .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Text("Project description:")
                TextField("Enter project description", text: $projectDescription, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
            }
        
            HStack {
                Text("Project money goal:")
                TextField("Enter money", value: $projectMoneyGoal, formatter: formatter)
                    .textFieldStyle(.roundedBorder)
            }
            
            DatePicker(selection: $projectDeadline, in: ...Date.distantFuture, displayedComponents: .date) {
                Text("Project deadline:")
            }
            Spacer()
            
            Button {
                if let image = projectUIImgae {
                    viewModel.uploadProject(image, name: projectName, desc: projectDescription, projectDeadline: projectDeadline, moneyGoal: projectMoneyGoal)
                }
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("CREATE NEW PROJECT")
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(width:300,height: 30)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("Primary"))
                    .cornerRadius(20)
            }
        }
        .padding()
        .onChange(of: projectPictureItem) { _ in
            Task {
                if let data = try? await projectPictureItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        projectUIImgae = uiImage
                        projectImage = Image(uiImage: uiImage)
                        return
                    }
                }
                print("Failed")
            }
        }
    }
}

struct CreateProjectView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProjectView()
    }
}
