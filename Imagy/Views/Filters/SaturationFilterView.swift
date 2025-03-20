//
//  SaturationFilterView.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import SwiftUI

struct SaturationFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    @State private var adjustment: Double = 1.2

    let onDisable: () -> Bool
    
    func apply() {
        SaturationFilter(modelData: $modelData, applyingFilter: $applyingFilter, adjustment: adjustment).apply()
    }
    
    var body: some View {
        FilterView {
            DoubleFilterSliderView(
                title: "Adjustment",
                value: $adjustment,
                range: 0.0...2.0,
                step: 0.1,
                onApply: apply,
                onDisable: onDisable
            )
        }
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    SaturationFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
