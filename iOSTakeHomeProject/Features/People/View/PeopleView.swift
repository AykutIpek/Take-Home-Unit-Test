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
    @State private var users: [User] = []
    @State private var shouldShowCreate = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                background
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(users, id: \.id) { user in
                            NavigationLink {
                                DetailView()
                            } label: {
                                PersonItemView(user: user)
                            }

                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                    
                }
            }
            .onAppear {
                NetworkingManager.shared.request("https://reqres.in/api/users",
                                                 type: UserResponse.self) { res in
                    switch res {
                    case .success(let response):
                        users = response.data
                    case .failure(let error):
                        print("DEBUG: Fetch json error in people view\(error.localizedDescription)")
                    }
                }
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateView()
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
    }
    
    var background: some View {
        Color(Theme.background.rawValue)
            .edgesIgnoringSafeArea(.all)
    }
}
