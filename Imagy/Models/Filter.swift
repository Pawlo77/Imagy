//
//  Filter.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import UIKit
import SwiftImage

protocol FilterProtocol : AnyObject {
    static var name: String { get }
    
    var modelData: ModelData { get set }
    var applyingFilter: Bool { get set }
    
    func apply() -> Void
    
    func applyTransformation(
        to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>
    ) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>>
    
    func applyKernel(
        kernel: [[Float]],
        to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>
    ) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>>
}

extension FilterProtocol {
    func apply() {
        DispatchQueue.global(qos: .userInitiated).async {
            print("Attempting to apply filter \(Self.name)...")
            
            if self.applyingFilter {
                print("Other filter is already being applied.")
                return
            }
            
            guard let originalImage = self.modelData.originalImage else {
                return
            }
            
            let originalSwiftImage = SwiftImage.Image<SwiftImage.RGBA<UInt8>>(uiImage: originalImage)
            
            self.applyingFilter = true
            print("Applying filter \(Self.name)...")
            
            // Call the transformation function (each filter defines its own logic)
            let outputImage = self.applyTransformation(to: originalSwiftImage)
            
            DispatchQueue.main.async {
                self.modelData.processedImage = outputImage.uiImage
                self.applyingFilter = false
                print("Done applying filter \(Self.name).")
            }
        }
    }
    
    func applyKernel(
        kernel: [[Float]],
        to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>
    ) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        let kernelWidth = kernel.count
        let radius = kernelWidth / 2
        var outputImage = inputImage
        
        // Apply the kernel with edge interpolation (using nearest neighbor replication)
        for x in 0..<inputImage.width {
            for y in 0..<inputImage.height {
                var redValue = Float(0.0)
                var greenValue = Float(0.0)
                var blueValue = Float(0.0)
                
                // We run the kernel over the region, considering the image boundaries
                for kernelX in 0..<kernelWidth {
                    for kernelY in 0..<kernelWidth {
                        let offsetX = kernelX - radius
                        let offsetY = kernelY - radius
                        
                        // Calculate the image pixel coordinates with boundary checks
                        let imageX = min(max(x + offsetX, 0), inputImage.width - 1)
                        let imageY = min(max(y + offsetY, 0), inputImage.height - 1)
                        
                        let kernelValue = kernel[kernelX][kernelY]
                        let pixel = inputImage[imageX, imageY]
                        
                        // Accumulate color values
                        redValue += Float(pixel.red) * kernelValue
                        greenValue += Float(pixel.green) * kernelValue
                        blueValue += Float(pixel.blue) * kernelValue
                    }
                }
                
                // Apply the new calculated RGB values to the output image
                outputImage[x, y].red = UInt8(min(max(0, redValue), 255))
                outputImage[x, y].green = UInt8(min(max(0, greenValue), 255))
                outputImage[x, y].blue = UInt8(min(max(0, blueValue), 255))
            }
        }
        
        return outputImage
    }
}
