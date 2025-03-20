//
//  LandingView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI

struct LandingView: View {
    @State private var isLoaded = false
    @State private var modelData = ModelData()
    
    var body: some View {
        if isLoaded {
            ContentView(
                modelData: $modelData
            )
        } else {
            SplashView()
                .onAppear {
                    loadAppData()
                }
        }
    }
    
    private func loadAppData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoaded = true
        }
    }
}

#Preview {
    LandingView()
}

