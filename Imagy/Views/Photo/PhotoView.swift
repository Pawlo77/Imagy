//
//  PhotoView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI

struct PhotoView: View {
    @Binding var image: UIImage?

    private var name: String
    private var description: String

    init(image: Binding<UIImage?>, name: String, description: String = "") {
        self._image = image
        self.name = name
        self.description = description
    }

    var body: some View {
        if let image = image {
            VStack{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height * 0.285)
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.285)
                Text(name)
                    .font(.headline)

            }
        } else {
            ContentUnavailableView(
                "No picture",
                systemImage: "photo.badge.plus",
                description: Text(description)
            )
        }
    }
}

#Preview {
    @Previewable @State var sampleImage: UIImage? = UIImage(named: "default")
    return PhotoView(image: $sampleImage, name: "Preview")
}
