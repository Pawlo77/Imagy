//
//  ContrastFilter.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class ContrastFilter: FilterProtocol {
    static var name: String = "Contrast"
    
    private var adjustment: Double
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>, adjustment: Double = 1.2) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
        self.adjustment = adjustment
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        var outputImage = inputImage
        
        for x in 0..<inputImage.width {
            for y in 0..<inputImage.height {
                let pixel = inputImage[x, y]
                
                outputImage[x, y].red = UInt8(min(255, max(0, Int((Double(pixel.red) - 128) * adjustment + 128))))
                outputImage[x, y].green = UInt8(min(255, max(0, Int((Double(pixel.green) - 128) * adjustment + 128))))
                outputImage[x, y].blue = UInt8(min(255, max(0, Int((Double(pixel.blue) - 128) * adjustment + 128))))
            }
        }
        
        return outputImage
    }
}
