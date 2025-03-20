//
//  BrightnessFilterView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI

struct BrightnessFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    @State private var intensity: Int = 50
    @State private var sigma: Double = 1.0

    let onDisable: () -> Bool
    
    func apply() {
        BrightnessFilter(modelData: $modelData, applyingFilter: $applyingFilter, intensity: intensity).apply()
    }
    
    var body: some View {
        FilterView {
            IntegerFilterSliderView(
                title: "Intensity",
                description: "Filter strength",
                value: $intensity,
                range: -255...255,
                step: 1,
                onApply: apply,
                onDisable: onDisable
            )
        }
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    BrightnessFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
