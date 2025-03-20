//
//  NegativeFilter.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class NegativeFilter: FilterProtocol {
    static var name: String = "Negative"
    
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
                outputImage[x, y].red = 255 - inputImage[x, y].red
                outputImage[x, y].green = 255 - inputImage[x, y].green
                outputImage[x, y].blue = 255 - inputImage[x, y].blue
            }
        }
        
        return outputImage
    }
}
