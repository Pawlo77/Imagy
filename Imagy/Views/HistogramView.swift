//
//  HistogramView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI
import Charts
import SwiftImage

struct HistogramView: View {
    @Binding var image: UIImage?
    @Binding var calculatingHistogram: Bool
    @Binding var numberOfBins: Int
    
    @State private var redHistogram: [Int] = []
    @State private var greenHistogram: [Int] = []
    @State private var blueHistogram: [Int] = []
    
    let name: String
    
    var body: some View {
        BarChartView(image: $image, numberOfBins: $numberOfBins, redHistogram: $redHistogram, greenHistogram: $greenHistogram, blueHistogram: $blueHistogram, name: name, onApply: applyCalculateHistogram)
    }
    
    private func applyCalculateHistogram() {
        if calculatingHistogram {
            print("Histogram is already being calculated.")
            return
        }
        
        guard self.image != nil else {
            return
        }
        
        calculatingHistogram = true
        print("Calculating \(name) histogram...")
        DispatchQueue.global(qos: .userInitiated).async {
            computeHistogram()
        }
    }
    
    private func computeHistogram() {
        guard let image = self.image
        else {
            calculatingHistogram = false
            return
        }
        
        let swiftImage = SwiftImage.Image<SwiftImage.RGBA<UInt8>>(uiImage: image)
        
        var rawRedHistogram = [Int](repeating: 0, count: 256)
        var rawGreenHistogram = [Int](repeating: 0, count: 256)
        var rawBlueHistogram = [Int](repeating: 0, count: 256)
        
        for x in 0..<(swiftImage.width) {
            for y in 0..<(swiftImage.height) {
                let pixel = swiftImage[x, y]
                
                rawRedHistogram[Int(pixel.red)] += 1
                rawGreenHistogram[Int(pixel.green)] += 1
                rawBlueHistogram[Int(pixel.blue)] += 1
            }
        }
        
        
        let binSize = 256.0 / Double(numberOfBins)
        
        var binnedRed = [Int](repeating: 0, count: numberOfBins)
        var binnedGreen = [Int](repeating: 0, count: numberOfBins)
        var binnedBlue = [Int](repeating: 0, count: numberOfBins)
        
        for i in 0...255 {
            let binIndex = min(Int(Double(i) / binSize), numberOfBins - 1)
            binnedRed[binIndex] += rawRedHistogram[i]
            binnedGreen[binIndex] += rawGreenHistogram[i]
            binnedBlue[binIndex] += rawBlueHistogram[i]
        }
        
        DispatchQueue.main.async {
            self.redHistogram = binnedRed
            self.greenHistogram = binnedGreen
            self.blueHistogram = binnedBlue
            self.calculatingHistogram = false
            print("Histogram \(name) calculated successfully...")
        }
    }
}

#Preview {
    @Previewable @State var sampleImage: UIImage? = UIImage(named: "default")
    @Previewable @State var numberOfBins = 16
    
    return HistogramView(
        image: $sampleImage,
        calculatingHistogram: .constant(false),
        numberOfBins: $numberOfBins,
        name: "Preview"
    )
}
