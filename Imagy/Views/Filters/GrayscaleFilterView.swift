//
//  GrayscaleFilterView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI

struct GrayscaleFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    let onDisable: () -> Bool
    
    func apply() {
        GrayscaleFilter(modelData: $modelData, applyingFilter: $applyingFilter).apply()
    }
    
    var body: some View {
        FilterView()
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    GrayscaleFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
