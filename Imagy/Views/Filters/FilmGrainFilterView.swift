//
//  FilmGrainFilterView.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import SwiftUI

struct FilmGrainFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    @State private var grainStrength: Double = 0.5

    let onDisable: () -> Bool
    
    func apply() {
        FilmGrainFilter(modelData: $modelData, applyingFilter: $applyingFilter, grainStrength: grainStrength).apply()
    }
    
    var body: some View {
        FilterView {
            DoubleFilterSliderView(
                title: "Strength",
                value: $grainStrength,
                range: 0.0...1.0,
                step: 0.01,
                onApply: apply,
                onDisable: onDisable
            )
        }
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    FilmGrainFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
