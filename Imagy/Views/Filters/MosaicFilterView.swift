//
//  MosaicFilterView.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import SwiftUI

struct MosaicFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    @State private var blockSize: Int = 10

    let onDisable: () -> Bool
    
    func apply() {
        MosaicFilter(modelData: $modelData, applyingFilter: $applyingFilter, blockSize: blockSize).apply()
    }
    
    var body: some View {
        FilterView {
            IntegerFilterSliderView(
                title: "Block Size",
                value: $blockSize,
                range: 2...15,
                step: 1,
                onApply: apply,
                onDisable: onDisable
            )
        }
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    MosaicFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
