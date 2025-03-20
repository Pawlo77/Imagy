//
//  FilterView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI

protocol FilterViewProtocol: View {
    var modelData: ModelData { get set }
    var applyingFilter: Bool { get set }
    
    func apply() -> Void
}

struct FilterView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content = { Text("No additional filter settings") }) {
        self.content = content
    }

    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                content()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.thinMaterial)
                .shadow(radius: 10)
        )
    }
}

#Preview {
    FilterView()
}
