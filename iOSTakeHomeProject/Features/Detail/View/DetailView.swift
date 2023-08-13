//
//  DetailView.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 12.08.2023.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
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
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
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
            PillView(id: 0)
            
            // View Builders
            Group {
                firstName
                lastName
                email
            }
            .foregroundColor(Color(Theme.text.rawValue))
        }
    }
    
    var link: some View {
        Link(destination: .init(string: "https://reqres.in/#support-heading")!) {
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Support Reqres")
                    .foregroundColor(Color(Theme.text.rawValue))
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
                Text("https://reqres.in/#support-heading")
            }
            Spacer()
            
            Image(systemName: Symbols.link.rawValue)
                .font(.system(.title3, design: .rounded))
            
        }
    }
    
    @ViewBuilder
    var firstName: some View {
        Text("First Name")
            .font(.system(.body, design: .rounded))
            .fontWeight(.semibold)
        Text("<First Name Here>")
            .font(.system(.subheadline, design: .rounded))
        Divider()
    }
    
    
    @ViewBuilder
    var lastName: some View {
        Text("Last Name")
            .font(.system(.body, design: .rounded))
            .fontWeight(.semibold)
        Text("<Last Name Here>")
            .font(.system(.subheadline, design: .rounded))
        Divider()
    }
    
    @ViewBuilder
    var email: some View {
        
        Text("Email")
            .font(.system(.body, design: .rounded))
            .fontWeight(.semibold)
        Text("<Email Here>")
            .font(.system(.subheadline, design: .rounded))
    }
}
