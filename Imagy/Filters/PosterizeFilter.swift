//
//  PosterizeFilter.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class PosterizeFilter: FilterProtocol {
    static var name: String = "Posterize"
    
    private var levels: Int
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>, levels: Int = 4) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
        self.levels = levels
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        var outputImage = inputImage
        let step = 255 / (levels - 1)
        
        for x in 0..<inputImage.width {
            for y in 0..<inputImage.height {
                let pixel = inputImage[x, y]
                
                let newRed = UInt8(Double(pixel.red) * Double(step) / 255.0) * UInt8(255 / step)
                let newGreen = UInt8(Double(pixel.green) * Double(step) / 255.0) * UInt8(255 / step)
                let newBlue = UInt8(Double(pixel.blue) * Double(step) / 255.0) * UInt8(255 / step)
                
                outputImage[x, y].red = newRed
                outputImage[x, y].green = newGreen
                outputImage[x, y].blue = newBlue
            }
        }
        
        return outputImage
    }
}
