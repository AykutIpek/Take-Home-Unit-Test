//
//  PeopleView.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 12.08.2023.
//

import SwiftUI

struct PeopleView: View {
    //MARK: - Properties
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    @StateObject private var viewModel = PeopleViewModel()
    @State private var shouldShowCreate = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                background
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .mint))
                            .scaleEffect(2.0, anchor: .center)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.users, id: \.id) { user in
                                NavigationLink {
                                    DetailView(userId: user.id)
                                } label: {
                                    PersonItemView(user: user)
                                }

                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                    
                }
            }
            .onAppear {
                viewModel.fetchUser()
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateView()
            }
            .alert(isPresented: $viewModel.hasError, error: viewModel.error) {
                Button("Retry") {
                    viewModel.fetchUser()
                }
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}


private extension PeopleView {
    var create: some View {
        Button {
            shouldShowCreate.toggle()
        } label: {
            Image(systemName: Symbols.plus.rawValue)
                .font(.system(.headline, design: .rounded))
                .fontWeight(.bold)
        }
        .disabled(viewModel.isLoading)
    }
    
    var background: some View {
        Color(Theme.background.rawValue)
            .edgesIgnoringSafeArea(.all)
    }
}
