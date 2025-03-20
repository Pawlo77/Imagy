//
//  CustomKernelFilterView.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import SwiftUI

struct CustomKernelFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    @State private var kernelSize: Int = 3
    @State private var kernel: [[Float]] = Array(repeating: Array(repeating: 1, count: 3), count: 3)

    let onDisable: () -> Bool
    
    func apply() {
        CustomKernelFilter(modelData: $modelData, applyingFilter: $applyingFilter, kernel: kernel).apply()
    }
    
    var body: some View {
        FilterView {
            IntegerFilterSliderView(
                title: "Kernel Size",
                value: $kernelSize,
                range: 3...5,
                step: 2,
                onApply: recalculateKernel,
                onDisable: onDisable
            )
            
            GridView(kernel: $kernel)
            
            Button(action: apply) {
                Text("Apply")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)
            }
            .disabled(onDisable())
            .padding(.bottom)
        }
    }
    
    private func recalculateKernel() {
        kernel = Array(repeating: Array(repeating: 1, count: kernelSize), count: kernelSize)
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    CustomKernelFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
