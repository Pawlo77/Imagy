//
//  GlitchFilterView.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import SwiftUI

struct GlitchFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    let onDisable: () -> Bool
    
    func apply() {
        GlitchFilter(modelData: $modelData, applyingFilter: $applyingFilter).apply()
    }
    
    var body: some View {
        FilterView()
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    GlitchFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
