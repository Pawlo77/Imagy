//
//  SobelFilterView.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import SwiftUI

struct SobelFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    let onDisable: () -> Bool
    
    func apply() {
        SobelFilter(modelData: $modelData, applyingFilter: $applyingFilter).apply()
    }
    
    var body: some View {
        FilterView()
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    SobelFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
