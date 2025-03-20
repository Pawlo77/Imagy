//
//  EmbossFilter.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import UIKit
import SwiftUI
import SwiftImage

class EmbossFilter: FilterProtocol {
    static var name: String = "Emboss"
    
    private var kernel: [[Float]]
    
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    
    init(modelData: Binding<ModelData>, applyingFilter: Binding<Bool>, kernelType: EmbossKernelType = .default) {
        self._modelData = modelData
        self._applyingFilter = applyingFilter
        self.kernel = EmbossFilter.generateEmbossKernel(type: kernelType)
    }
    
    func applyTransformation(to inputImage: SwiftImage.Image<SwiftImage.RGBA<UInt8>>) -> SwiftImage.Image<SwiftImage.RGBA<UInt8>> {
        return applyKernel(
            kernel: kernel,
            to: inputImage
        )
    }
    
    static func generateEmbossKernel(type: EmbossKernelType) -> [[Float]] {
        switch type {
        case .strong:
            return [
                [-2, -1,  0],
                [-1,  1,  1],
                [ 0,  1,  2]
            ]
        case .default:
            return [
                [-1, -1,  0],
                [-1,  1,  1],
                [  0,  1,  1]
            ]
        case .soft:
            return [
                [-1, -0.5,  0],
                [-0.5,  1,  0.5],
                [  0,  0.5,  1]
            ]
        }
    }
}

enum EmbossKernelType: String, CaseIterable, Identifiable {
    case `default` = "Default"
    case strong = "Strong"
    case soft = "Soft"

    var id: Self { self }
}
