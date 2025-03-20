//
//  FilmGrainFilter.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class FilmGrainFilter: FilterProtocol {
    static var name: String = "Film Grain"
    
    private var grainStrength: Double
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>, grainStrength: Double = 0.1) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
        self.grainStrength = grainStrength
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        var outputImage = inputImage
        
        for x in 0..<inputImage.width {
            for y in 0..<inputImage.height {
                var pixel = inputImage[x, y]
                
                // Apply random noise to simulate film grain
                let noise = Int.random(in: -Int(grainStrength * 255)...Int(grainStrength * 255))
                
                pixel.red = UInt8(min(max(Int(pixel.red) + noise, 0), 255))
                pixel.green = UInt8(min(max(Int(pixel.green) + noise, 0), 255))
                pixel.blue = UInt8(min(max(Int(pixel.blue) + noise, 0), 255))
                
                outputImage[x, y] = pixel
            }
        }
        
        return outputImage
    }
}
