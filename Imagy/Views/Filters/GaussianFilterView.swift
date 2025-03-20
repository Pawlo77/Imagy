//
//  GaussianFilterView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI

struct GaussianFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    @State private var kernelSize: Int = 3
    @State private var sigma: Double = 1.0

    let onDisable: () -> Bool
    
    func apply() {
        GaussianFilter(modelData: $modelData, applyingFilter: $applyingFilter, kernelSize: kernelSize, sigma: Float(sigma)).apply()
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
            DoubleFilterSliderView(
                title: "Sigma",
                description: "for kernel initialization",
                value: $sigma,
                range: 0.1...3.0,
                step: 0.1,
                onApply: apply,
                onDisable: onDisable
            )
        }
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    GaussianFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
