//
//  SharpeningFilter.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class SharpeningFilter: FilterProtocol {
    static var name: String = "Sharpening"
    
    private var kernel: [[Float]] = [
        [0, -1 , 0],
        [-1, 5, -1],
        [0, -1 , 0]
    ]
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        return applyKernel(
            kernel: kernel,
            to: inputImage
        )
    }
}
