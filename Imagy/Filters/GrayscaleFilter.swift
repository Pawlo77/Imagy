//
//  GrayscaleFilter.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class GrayscaleFilter: FilterProtocol {
    static var name: String = "Grayscale"
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        var outputImage = inputImage
        
        for x in 0..<(inputImage.width) {
            for y in 0..<(inputImage.height) {
                let red = inputImage[x, y].red
                let green = inputImage[x, y].green
                let blue = inputImage[x, y].blue
                
                let gray = UInt8((UInt16(red) + UInt16(green) + UInt16(blue)) / 3)
                
                outputImage[x, y].red = gray
                outputImage[x, y].green = gray
                outputImage[x, y].blue = gray
            }
        }
        
        return outputImage
    }
}
