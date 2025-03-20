//
//  SobelFilter.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class SobelFilter: FilterProtocol {
    static var name: String = "Sobel"
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    private let kernelX: [[Float]] = [
        [ 1,  0, -1],
        [ 2,  0, -2],
        [ 1,  0, -1]
    ]
    private let kernelY: [[Float]] = [
        [ 1,  2,  1],
        [ 0,  0,  0],
        [-1, -2, -1]
    ]
    
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
            let gradientX = applyKernel(kernel: kernelX, to: inputImage)
            let gradientY = applyKernel(kernel: kernelY, to: inputImage)
            var outputImage = inputImage
            
            // Combine the gradients to compute edge magnitudes
            for y in 0..<inputImage.height {
                for x in 0..<inputImage.width {
                    let gradX = gradientX[x, y]
                    let gradY = gradientY[x, y]
                    
                    outputImage[x, y].red = getMagnitude(gradX: gradX.red, gradY: gradY.red)
                    outputImage[x, y].green = getMagnitude(gradX: gradX.green, gradY: gradY.green)
                    outputImage[x, y].blue = getMagnitude(gradX: gradX.blue, gradY: gradY.blue)
                }
            }
            
            return outputImage
        }
    
    private func getMagnitude(gradX: UInt8, gradY: UInt8) -> UInt8 {
        let gradXDouble = Double(gradX)
        let gradYDouble = Double(gradY)
        let magnitude = sqrt(gradXDouble * gradXDouble + gradYDouble * gradYDouble)
        let value = UInt8(min(255, magnitude))
        return value
    }
}
