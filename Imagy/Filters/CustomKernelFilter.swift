//
//  CustomKernelFilter.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class CustomKernelFilter: FilterProtocol {
    static var name: String = "Custom Kernel"
    
    private var kernel: [[Float]]
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>, kernel: [[Float]]) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
        self.kernel = kernel
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        return applyKernel(
            kernel: kernel,
            to: inputImage
        )
    }
}

