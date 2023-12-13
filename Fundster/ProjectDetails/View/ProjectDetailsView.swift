//
//  ProjectDetailsView.swift
//  Fundster
//
//  Created by Martin Novak on 11.10.2023..
//

import SwiftUI

struct ProjectDetailsView: View {
    @ObservedObject var viewModel: ProjectDetailViewModel
    @State private var sheetShowing = false
    @State private var money: Int = 0
    var body: some View {
        VStack {
            AsyncImage(
                url: URL(string: viewModel.project.projectPictureUrl ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Tsunami_by_hokusai_19th_century.jpg/700px-Tsunami_by_hokusai_19th_century.jpg"),
                    content: { image in
                        image
                            .resizable()
                            .frame(height:200)
                            .aspectRatio(contentMode: .fit)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
            VStack(alignment: .leading) {
                HStack(spacing: 30) {
                    AsyncImage(
                        url: URL(string: viewModel.projectUser?.profilePictureUrl ?? ""),
                            content: { image in
                                image
                                    .resizable()
                                    .frame(width:50,height:50)
                                    .clipShape(Circle())
                                    .aspectRatio(contentMode: .fit)
                                    },
                                    placeholder: {
                                        Image("profile")
                                           .resizable()
                                           .frame(width:50,height:50)
                                           .clipShape(Circle())
                                           .aspectRatio(contentMode: .fit)
                                    }
                                )
                    Text(viewModel.projectUser?.name ?? "")
                        .bold()
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                
                Text(viewModel.project.name ?? "Title")
                    .font(.largeTitle)
                    .bold()
                ProgressBar(moneyAcquired: viewModel.project.moneyAcquired ?? 0, moneyGoal: viewModel.project.moneyGoal ?? 0)
                    
                HStack {
                    CustomDetailComponent(project: viewModel.project, componentType: DetailComponentType.funded)

                    Spacer()
                    CustomDetailComponent(project: viewModel.project, componentType: DetailComponentType.backers)

                    Spacer()
                    CustomDetailComponent(project: viewModel.project, componentType: DetailComponentType.days)

                }
                .padding(.top, 20)
                .padding(.bottom, 40)
                
                Text(viewModel.project.description ?? "This is the description of the project, and this is what the project is for")
                    .foregroundColor(.gray)
                    .font(.title3)
                    Spacer()
                HStack {
                    Spacer()
                    Button {
                        sheetShowing.toggle()
                    } label: {
                        Text("BACK THIS PROJECT")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(width: 250,height: 30)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("Primary"))
                            .cornerRadius(20)
                    }
                    Spacer()
                }
                .padding(.bottom, 50)
                .sheet(isPresented: $sheetShowing, onDismiss: {
                    viewModel.updateProject(money: money)
                }) {
                    FundView(number: $money)
                }
                
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
        
        .ignoresSafeArea()
    }
}

struct ProjectDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDetailsView(viewModel: ProjectDetailViewModel(project: Project(id: 205, name: "Asdasd", projectPictureUrl: "https://firebasestorage.googleapis.com:443/v0/b/fundster-f5983.appspot.com/o/projectImages%2FB293AD92-8254-47D0-9664-585B3B127D6E?alt=media&token=1530e9f6-850e-45a4-988e-f83884dba5e4", description: "Description", moneyGoal: 12341, moneyAcquired: 0, backers: 0, deadline: Date(), userID: 1)))
    }
}
