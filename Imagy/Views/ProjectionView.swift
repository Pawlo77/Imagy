//
//  ProjectionView.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import SwiftUI
import Charts
import SwiftImage

struct ProjectionView: View {
    @Binding var image: UIImage?
    @Binding var calculatingProjection: Bool
    
    @State private var horizontalRedProjection: [Int] = []
    @State private var horizontalGreenProjection: [Int] = []
    @State private var horizontalBlueProjection: [Int] = []
    @State private var verticalRedProjection: [Int] = []
    @State private var verticalGreenProjection: [Int] = []
    @State private var verticalBlueProjection: [Int] = []
    
    @State private var horizontalNumberOfBins: Int = 0
    @State private var verticalNumberOfBins: Int = 0
    
    let name: String
    
    var body: some View {
        NavigationStack {
            TabView {
                // Horizontal Projection Chart
                BarChartView(
                    image: $image,
                    numberOfBins: $horizontalNumberOfBins,
                    redHistogram: $horizontalRedProjection,
                    greenHistogram: $horizontalGreenProjection,
                    blueHistogram: $horizontalBlueProjection,
                    name: "\(name) - Horizontal Projection",
                    onApply: applyCalculateProjections
                )
                .tag(0)
                
                // Vertical Projection Chart
                BarChartView(
                    image: $image,
                    numberOfBins: $verticalNumberOfBins,
                    redHistogram: $verticalRedProjection,
                    greenHistogram: $verticalGreenProjection,
                    blueHistogram: $verticalBlueProjection,
                    name: "\(name) - Vertical Projection",
                    onApply: applyCalculateProjections
                )
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
    }
    
    private func applyCalculateProjections() {
        if calculatingProjection {
            print("Projection is already being calculated.")
            return
        }
        
        guard self.image != nil else {
            return
        }
        
        calculatingProjection = true
        print("Calculating projections for \(name)...")
        
        DispatchQueue.global(qos: .userInitiated).async {
            computeProjections()
        }
    }
    
    private func computeProjections() {
        guard let image = self.image else {
            calculatingProjection = false
            return
        }

        let swiftImage = SwiftImage.Image<SwiftImage.RGBA<UInt8>>(uiImage: image)
        horizontalNumberOfBins = swiftImage.height
        verticalNumberOfBins = swiftImage.width
        
        var horizontalRedProjection = [Int](repeating: 0, count: swiftImage.height)
        var horizontalGreenProjection = [Int](repeating: 0, count: swiftImage.height)
        var horizontalBlueProjection = [Int](repeating: 0, count: swiftImage.height)
        
        var verticalRedProjection = [Int](repeating: 0, count: swiftImage.width)
        var verticalGreenProjection = [Int](repeating: 0, count: swiftImage.width)
        var verticalBlueProjection = [Int](repeating: 0, count: swiftImage.width)
        
        // Calculate horizontal and vertical projections
        for x in 0..<swiftImage.width {
            for y in 0..<swiftImage.height {
                let pixel = swiftImage[x, y]
                
                // Horizontal projection (sum of pixels in each row)
                horizontalRedProjection[y] += Int(pixel.red)
                horizontalGreenProjection[y] += Int(pixel.green)
                horizontalBlueProjection[y] += Int(pixel.blue)
                
                // Vertical projection (sum of pixels in each column)
                verticalRedProjection[x] += Int(pixel.red)
                verticalGreenProjection[x] += Int(pixel.green)
                verticalBlueProjection[x] += Int(pixel.blue)
            }
        }
        
        DispatchQueue.main.async {
            self.horizontalRedProjection = horizontalRedProjection
            self.horizontalGreenProjection = horizontalGreenProjection
            self.horizontalBlueProjection = horizontalBlueProjection
            self.verticalRedProjection = verticalRedProjection
            self.verticalGreenProjection = verticalGreenProjection
            self.verticalBlueProjection = verticalBlueProjection
            
            self.calculatingProjection = false
            print("Projections for \(name) calculated successfully...")
        }
    }
}

#Preview {
    @Previewable @State var sampleImage: UIImage? = UIImage(named: "default")
    
    ProjectionView(
        image: $sampleImage,
        calculatingProjection: .constant(false),
        name: "Projection View"
    )
}
