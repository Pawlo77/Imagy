//
//  ModelData.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI
import Foundation
import PhotosUI
import SwiftImage

@Observable class ModelData {
    var originalImage: UIImage?
    var processedImage: UIImage?
    var selectedItem: PhotosPickerItem?
}
