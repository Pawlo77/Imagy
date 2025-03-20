//
//  PhotoPickerView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @Binding var modelData: ModelData
    let onLoadImage: (UIImage?) -> Void
    
    var body: some View {
        PhotosPicker(selection: $modelData.selectedItem, matching: .images) {
            content
        }
        .buttonStyle(.plain)
        .onChange(of: modelData.selectedItem) { _, newItem in
            loadImage(from: newItem)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    @ViewBuilder
    private var content: some View {
        PhotoView(
            image: $modelData.originalImage,
            name: "Original Image",
            description:"Tap to import a photo"
        )
    }

    private func loadImage(from item: PhotosPickerItem?) {
        guard let item else { return }
        
        item.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                if case .success(let imageData) = result,
                   let data = imageData,
                   let uiImage = UIImage(data: data) {
                    
                    modelData.originalImage = uiImage
                    modelData.processedImage = uiImage
                    onLoadImage(uiImage)
                }
            }
        }
    }
}

#Preview {
    PhotoPickerView(
        modelData: .constant(ModelData()),
        onLoadImage: { _ in }
    )
}
