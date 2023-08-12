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
    
    var body: some View {
        NavigationStack {
            ZStack {
                background
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(users, id: \.id) { user in
                            PersonItemView(user: user)
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
                do {
                    let res = try StaticJSONMapper.decode(file: "UserStaticData",
                                                                type: UserResponse.self)
                    users = res.data
                } catch {
                    print("DEBUG: PeopleView fetch json error: \(error.localizedDescription)")
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
            //
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
