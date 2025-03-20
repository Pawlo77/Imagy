//
//  SaturationFilter.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class SaturationFilter: FilterProtocol {
    static var name: String = "Saturation"
    
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
                
                let grayValue = 0.299 * Double(pixel.red) + 0.587 * Double(pixel.green) + 0.114 * Double(pixel.blue)
                
                outputImage[x, y].red = UInt8(min(255, max(0, Int(grayValue + adjustment * (Double(pixel.red) - grayValue)))))
                outputImage[x, y].green = UInt8(min(255, max(0, Int(grayValue + adjustment * (Double(pixel.green) - grayValue)))))
                outputImage[x, y].blue = UInt8(min(255, max(0, Int(grayValue + adjustment * (Double(pixel.blue) - grayValue)))))
            }
        }
        
        return outputImage
    }
}
