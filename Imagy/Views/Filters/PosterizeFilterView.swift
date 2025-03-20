//
//  PosterizeFilterView.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import SwiftUI

struct PosterizeFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    @State private var levels: Int = 3
    
    let onDisable: () -> Bool
    
    func apply() {
        PosterizeFilter(modelData: $modelData, applyingFilter: $applyingFilter, levels: levels).apply()
    }
    
    var body: some View {
        FilterView {
            IntegerFilterSliderView(
                title: "Levels",
                value: $levels,
                range: 2...128,
                step: 2,
                onApply: apply,
                onDisable: onDisable
            )
        }
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    PosterizeFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
