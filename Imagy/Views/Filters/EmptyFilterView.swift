//
//  EmptyFilterView.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import SwiftUI

struct EmptyFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    let onDisable: () -> Bool
    
    func apply() {
        
    }
    
    var body: some View {
        FilterView()
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    EmptyFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
