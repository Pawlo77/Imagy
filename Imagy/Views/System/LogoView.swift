//
//  LogoView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        ZStack {
            Image("icon")
                .resizable()
                .scaledToFit()
                .frame(width: 0.15 * UIScreen.main.bounds.height, height: 0.15 * UIScreen.main.bounds.height)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .shadow(radius: 10)
    }
}

#Preview {
    LogoView()
}
