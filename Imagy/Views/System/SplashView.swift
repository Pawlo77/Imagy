//
//  SplashView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            LogoView()
            
            Text("Welcome to Imagy")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ProgressView("Loading...")
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.1))
        .edgesIgnoringSafeArea(.all)
    }
}
#Preview {
    SplashView()
}
