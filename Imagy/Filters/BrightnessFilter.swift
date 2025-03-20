//
//  BrightnessFilter.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class BrightnessFilter: FilterProtocol {
    static var name: String = "Brightness Correction"
    
    private var intensity: Int
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>, intensity: Int = 50) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
        self.intensity = intensity
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        var outputImage = inputImage
        
        for x in 0..<(inputImage.width) {
            for y in 0..<(inputImage.height) {
                outputImage[x, y].red = applyIntensity(inputImage[x, y].red)
                outputImage[x, y].green = applyIntensity(inputImage[x, y].green)
                outputImage[x, y].blue = applyIntensity(inputImage[x, y].blue)
            }
        }
        
        return outputImage
    }
    
    private func applyIntensity(_ pixel: UInt8) -> UInt8 {
        let result = Int(pixel) + intensity
        return UInt8(clamping: result)
    }
}
