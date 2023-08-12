//
//  PillView.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 12.08.2023.
//

import SwiftUI

struct PillView: View {
    let id: Int
    var body: some View {
        Text("#\(id)")
            .font(.system(.caption, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(Color(Theme.pill.rawValue),in: Capsule())
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        PillView(id: 0)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
