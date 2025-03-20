//
//  AveragingFilterView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI

struct AveragingFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    @State private var kernelSize: Int = 3
    
    let onDisable: () -> Bool
    
    func apply() {
        AveragingFilter(modelData: $modelData, applyingFilter: $applyingFilter, kernelSize: kernelSize).apply()
    }
    
    var body: some View {
        FilterView {
            IntegerFilterSliderView(
                title: "Kernel Size",
                value: $kernelSize,
                range: 3...21,
                step: 2,
                onApply: apply,
                onDisable: onDisable
            )
        }
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    AveragingFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
