//
//  AveragingFilter.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class AveragingFilter: FilterProtocol {
    static var name: String = "Averaging"
    
    private var kernel: [[Float]]
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>, kernelSize: Int = 3) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
        self.kernel = AveragingFilter.generateAveragingKernel(size: kernelSize)
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        return applyKernel(
            kernel: kernel,
            to: inputImage
        )
    }
    
    static func generateAveragingKernel(size: Int) -> [[Float]] {
        guard size % 2 == 1, size > 1 else {
            fatalError("Size must be an odd number greater than 1")
        }
        
        let value = 1.0 / Float(size * size) // Each cell gets an equal weight
        return Array(repeating: Array(repeating: value, count: size), count: size)
    }
}
