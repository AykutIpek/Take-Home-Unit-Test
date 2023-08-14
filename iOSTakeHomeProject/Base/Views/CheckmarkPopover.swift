//
//  CheckmarkPopover.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 14.08.2023.
//

import SwiftUI

struct CheckmarkPopover: View {
    var body: some View {
        Image(systemName: Symbols.checkmark.rawValue)
            .font(.system(.largeTitle, design: .rounded))
            .fontWeight(.bold)
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct CheckmarkPopover_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkPopover()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(.blue)
    }
}
