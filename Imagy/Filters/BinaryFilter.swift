//
//  BinaryFilter.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class BinaryFilter: FilterProtocol {
    static var name: String = "Binary"
    
    private var threshold: Int
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>, threshold: Int = 128) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
        self.threshold = threshold
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        var outputImage = GrayscaleFilter(modelData: $modelData, applyingFilter: $applyingFilter).applyTransformation(to: inputImage)
        
        for x in 0..<(inputImage.width) {
            for y in 0..<(inputImage.height) {
                let bin = applyThreshold(inputImage[x, y].red)
            
                outputImage[x, y].red = bin
                outputImage[x, y].green = bin
                outputImage[x, y].blue = bin
            }
        }
        
        return outputImage
    }
    
    private func applyThreshold(_ input: UInt8) -> UInt8 {
        return input < UInt8(threshold) ? 0 : 255
    }
}
