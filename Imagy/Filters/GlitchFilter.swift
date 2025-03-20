//
//  GlitchFilter.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class GlitchFilter: FilterProtocol {
    static var name: String = "Glitch"
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        var outputImage = inputImage
        
        // Randomly shift rows to create a "glitch" effect
        for y in 0..<inputImage.height {
            let shiftAmount = Int.random(in: -5...5)
            for x in 0..<inputImage.width {
                let newX = min(max(x + shiftAmount, 0), inputImage.width - 1)
                outputImage[x, y] = inputImage[newX, y]
            }
        }
        
        // Add random color noise
        for x in 0..<(inputImage.width) {
            for y in 0..<(inputImage.height) {
                outputImage[x, y].red = UInt8(min(255, max(0, Int(outputImage[x, y].red) + Int.random(in: -20...20))))
                outputImage[x, y].green = UInt8(min(255, max(0, Int(outputImage[x, y].green) + Int.random(in: -20...20))))
                outputImage[x, y].blue = UInt8(min(255, max(0, Int(outputImage[x, y].blue) + Int.random(in: -20...20))))
            }
        }
        
        return outputImage
    }
}
