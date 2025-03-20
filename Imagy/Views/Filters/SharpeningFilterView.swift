//
//  SharpeningFilterView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI

struct SharpeningFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    let onDisable: () -> Bool
    
    func apply() {
        SharpeningFilter(modelData: $modelData, applyingFilter: $applyingFilter).apply()
    }
    
    var body: some View {
        FilterView ()
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    SharpeningFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
