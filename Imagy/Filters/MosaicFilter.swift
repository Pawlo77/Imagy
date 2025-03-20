//
//  MosaicFilter.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class MosaicFilter: FilterProtocol {
    static var name: String = "Mosaic"
    
    private var blockSize: Int
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>, blockSize: Int = 10) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
        self.blockSize = blockSize
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        var outputImage = inputImage
                
        for x in stride(from: 0, to: inputImage.width, by: blockSize) {
            for y in stride(from: 0, to: inputImage.height, by: blockSize) {
                var averageRed: UInt16 = 0
                var averageGreen: UInt16 = 0
                var averageBlue: UInt16 = 0
                var count: Int = 0
                
                // Calculate the average color in the block
                for bx in 0..<blockSize {
                    for by in 0..<blockSize {
                        let nx = x + bx
                        let ny = y + by
                        
                        // Check if within bounds
                        if nx < inputImage.width && ny < inputImage.height {
                            averageRed += UInt16(inputImage[nx, ny].red)
                            averageGreen += UInt16(inputImage[nx, ny].green)
                            averageBlue += UInt16(inputImage[nx, ny].blue)
                            count += 1
                        }
                    }
                }
                
                if count > 0 {
                    averageRed /= UInt16(count)
                    averageGreen /= UInt16(count)
                    averageBlue /= UInt16(count)
                } else {
                    averageRed = 0
                    averageGreen = 0
                    averageBlue = 0
                }
                
                // Apply the average color to the block
                for bx in 0..<blockSize {
                    for by in 0..<blockSize {
                        let nx = x + bx
                        let ny = y + by
                        
                        // Check if within bounds and apply the average color
                        if nx < inputImage.width && ny < inputImage.height {
                            outputImage[nx, ny].red = UInt8(min(255, max(0, averageRed)))
                            outputImage[nx, ny].green = UInt8(min(255, max(0, averageGreen)))
                            outputImage[nx, ny].blue = UInt8(min(255, max(0, averageBlue)))
                        }
                    }
                }
            }
        }
        
        return outputImage
    }
}
