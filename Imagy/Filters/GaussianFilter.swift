//
//  GaussianFilter.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class GaussianFilter: FilterProtocol {
    static var name: String = "Gaussian Blur"
    
    private var kernel: [[Float]]
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>, kernelSize: Int = 3, sigma: Float = 1.0) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
        self.kernel = GaussianFilter.generateGaussianKernel(size: kernelSize, sigma: sigma)
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        return applyKernel(
            kernel: kernel,
            to: inputImage
        )
    }
    
    static func generateGaussianKernel(size: Int, sigma: Float) -> [[Float]] {
        guard size % 2 == 1, size > 1 else {
            fatalError("Size must be an odd number greater than 1")
        }
        
        let center = size / 2
        var kernel = Array(repeating: Array(repeating: Float(0.0), count: size), count: size)
        var sum: Float = 0.0

        // Compute Gaussian function for each cell
        for y in 0..<size {
            for x in 0..<size {
                let dx = Float(x - center)
                let dy = Float(y - center)
                let value = exp(-(dx * dx + dy * dy) / (2 * sigma * sigma)) / (2 * .pi * sigma * sigma)
                
                kernel[y][x] = value
                sum += value
            }
        }
        
        // Normalize kernel so values sum to 1
        for y in 0..<size {
            for x in 0..<size {
                kernel[y][x] /= sum
            }
        }
        
        return kernel
    }
}
