//
//  VignetteFilterView.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import SwiftUI

struct VignetteFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    @State private var intensity: Double = 0.5

    let onDisable: () -> Bool
    
    func apply() {
        VignetteFilter(modelData: $modelData, applyingFilter: $applyingFilter, intensity: intensity).apply()
    }
    
    var body: some View {
        FilterView {
            DoubleFilterSliderView(
                title: "Intensity",
                value: $intensity,
                range: 0.0...1.6,
                step: 0.1,
                onApply: apply,
                onDisable: onDisable
            )
        }
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    VignetteFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
