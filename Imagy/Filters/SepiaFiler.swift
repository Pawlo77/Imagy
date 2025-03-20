//
//  SepiaFiler.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class SepiaFilter: FilterProtocol {
    static var name: String = "Sepia"
    
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
                let pixel = inputImage[x, y]
                
                let tr = 0.393 * Float(pixel.red) + 0.769 * Float(pixel.green) + 0.189 * Float(pixel.blue)
                let tg = 0.349 * Float(pixel.red) + 0.686 * Float(pixel.green) + 0.168 * Float(pixel.blue)
                let tb = 0.272 * Float(pixel.red) + 0.534 * Float(pixel.green) + 0.131 * Float(pixel.blue)
                
                outputImage[x, y].red = UInt8(min(255, tr))
                outputImage[x, y].green = UInt8(min(255, tg))
                outputImage[x, y].blue = UInt8(min(255, tb))
            }
        }
        
        return outputImage
    }
}
