//
//  DetailView.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 12.08.2023.
//

import SwiftUI

struct DetailView: View {
    @State private var userInfo: UserDetailResponse?
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    
                    avatar
                    
                    Group {
                        general
                        link
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 18)
                    .background(Color(Theme.detailBackground.rawValue), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding()
            }
        }
        .navigationTitle("Details")
        .onAppear {
            do {
                userInfo = try StaticJSONMapper.decode(file: "SingleUserData",
                                                      type: UserDetailResponse.self)
            } catch {
                print("DEBUG: Single User data doesn't fetch in Detail View: \(error.localizedDescription)")
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView()
        }
    }
}


private extension DetailView {
    var background: some View {
        Color(Theme.background.rawValue)
            .edgesIgnoringSafeArea(.all)
    }
}


private extension DetailView {
    
    var general: some View {
        VStack(alignment: .leading, spacing: 8) {
            PillView(id: userInfo?.data.id ?? 0)
            
            // View Builders
            Group {
                firstName
                lastName
                email
            }
            .foregroundColor(Color(Theme.text.rawValue))
        }
    }
    
    @ViewBuilder
    var avatar: some View {
        if let avatarAbsoluteString = userInfo?.data.avatar,
           let avatarUrl = URL(string: avatarAbsoluteString) {
            AsyncImage(url: avatarUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

        }
    }
    
    @ViewBuilder
    var link: some View {
        
        if let supportAbsoluteString = userInfo?.support.url,
        let supportUrl = URL(string: supportAbsoluteString),
           let supportTxt = userInfo?.support.text {
            Link(destination: supportUrl) {
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(supportTxt)
                        .foregroundColor(Color(Theme.text.rawValue))
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    Text(supportAbsoluteString)
                }
                Spacer()
                
                Image(systemName: Symbols.link.rawValue)
                    .font(.system(.title3, design: .rounded))
                
            }
        }
    }
    
    @ViewBuilder
    var firstName: some View {
        Text("First Name")
            .font(.system(.body, design: .rounded))
            .fontWeight(.semibold)
        Text(userInfo?.data.firstName ?? "-")
            .font(.system(.subheadline, design: .rounded))
        Divider()
    }
    
    
    @ViewBuilder
    var lastName: some View {
        Text("Last Name")
            .font(.system(.body, design: .rounded))
            .fontWeight(.semibold)
        Text(userInfo?.data.lastName ?? "-")
            .font(.system(.subheadline, design: .rounded))
        Divider()
    }
    
    @ViewBuilder
    var email: some View {
        
        Text("Email")
            .font(.system(.body, design: .rounded))
            .fontWeight(.semibold)
        Text(userInfo?.data.email ?? "-")
            .font(.system(.subheadline, design: .rounded))
    }
}
