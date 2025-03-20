//
//  BinaryFilterView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI

struct BinaryFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    @State private var threshold: Int = 128

    let onDisable: () -> Bool
    
    func apply() {
        BinaryFilter(modelData: $modelData, applyingFilter: $applyingFilter, threshold: threshold).apply()
    }
    
    var body: some View {
        FilterView {
            IntegerFilterSliderView(
                title: "Threshold",
                value: $threshold,
                range: 1...255,
                step: 1,
                onApply: apply,
                onDisable: onDisable
            )
        }
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    BinaryFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
