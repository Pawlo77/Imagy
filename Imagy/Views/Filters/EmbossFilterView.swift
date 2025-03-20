//
//  EmbossFilterView.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import SwiftUI

struct EmbossFilterView: FilterViewProtocol {
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    let onDisable: () -> Bool
    @State private var selectedFilter: EmbossKernelType = .default
    
    func apply() {
        EmbossFilter(
            modelData: $modelData,
            applyingFilter: $applyingFilter,
            kernelType: selectedFilter
        ).apply()
    }
    
    var body: some View {
        FilterView {
            HStack {
                Image(systemName: "camera.filters")
                    .foregroundColor(.blue)
                
                Picker("Select a Filter", selection: $selectedFilter) {
                    ForEach(EmbossKernelType.allCases) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .disabled(onDisable())
                .onChange(of: selectedFilter) {
                    apply()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
        }
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    EmbossFilterView(
        modelData: $modelData,
        applyingFilter: .constant(false),
        onDisable: { false }
    )
}
