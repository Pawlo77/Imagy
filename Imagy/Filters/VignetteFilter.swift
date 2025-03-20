//
//  VignetteFilter.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class VignetteFilter: FilterProtocol {
    static var name: String = "Vignette"
    
    private var intensity: Double
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>, intensity: Double = 0.5) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
        self.intensity = intensity
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        var outputImage = inputImage
        
        let centerX = Double(inputImage.width) / 2
        let centerY = Double(inputImage.height) / 2
        let maxDistance = sqrt(centerX * centerX + centerY * centerY)
        
        for x in 0..<inputImage.width {
            for y in 0..<inputImage.height {
                let distance = sqrt(Double((x - Int(centerX)) * (x - Int(centerX))) + Double((y - Int(centerY)) * (y - Int(centerY))))
                let intensityFactor = 1.0 - min(distance / maxDistance, 1.0) * intensity
                
                outputImage[x, y].red = UInt8(min(255, max(0, Int(Double(outputImage[x, y].red) * intensityFactor))))
                outputImage[x, y].green = UInt8(min(255, max(0, Int(Double(outputImage[x, y].green) * intensityFactor))))
                outputImage[x, y].blue = UInt8(min(255, max(0, Int(Double(outputImage[x, y].blue) * intensityFactor))))
            }
        }
        
        return outputImage
    }
}
