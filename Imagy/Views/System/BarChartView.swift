import SwiftUI
import Charts
import SwiftImage

struct BarChartView: View {
    @Binding var image: UIImage?
    @Binding var numberOfBins: Int
    
    @Binding var redHistogram: [Int]
    @Binding var greenHistogram: [Int]
    @Binding var blueHistogram: [Int]
    
    let name: String
    
    let onApply: () -> Void
    
    @State private var calculated: Bool = false
    
    var body: some View {
        VStack {
            if let _ = image {
                VStack {
                    Chart {
                        ForEach(0..<numberOfBins, id: \.self) { binIndex in
                            if binIndex < redHistogram.count && redHistogram[binIndex] > 0 {
                                BarMark(
                                    x: .value("Intensity", binIndex),
                                    y: .value("Count", redHistogram[binIndex]),
                                    width: 8
                                )
                                .foregroundStyle(.red.opacity(0.7))
                            }
                            
                            if binIndex < greenHistogram.count && greenHistogram[binIndex] > 0 {
                                BarMark(
                                    x: .value("Intensity", binIndex),
                                    y: .value("Count", greenHistogram[binIndex]),
                                    width: 8
                                )
                                .foregroundStyle(.green.opacity(0.7))
                            }
                            
                            if binIndex < blueHistogram.count && blueHistogram[binIndex] > 0 {
                                BarMark(
                                    x: .value("Intensity", binIndex),
                                    y: .value("Count", blueHistogram[binIndex]),
                                    width: 8
                                )
                                .foregroundStyle(.blue.opacity(0.7))
                            }
                        }
                    }
                    .chartXScale(domain: 0...numberOfBins)
                    Text(name)
                        .font(.headline)
                        .padding(.top, 5)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height * 0.3)
                .onAppear {
                    if !calculated {
                        onApply()
                        self.calculated = true
                    }
                }
                .onChange(of: image) {
                    onApply()
                }
                .onChange(of: numberOfBins) {
                    onApply()
                }
            } else {
                ContentUnavailableView(
                    "No picture",
                    systemImage: "photo.badge.plus",
                    description: Text("Load an image to see the histogram.")
                )
            }
        }
    }
}

#Preview {
    @Previewable @State var sampleImage: UIImage? = UIImage(named: "default")
    @Previewable @State var redHistogram: [Int] = Array(repeating: 0, count: 16)
    @Previewable @State var greenHistogram: [Int] = Array(repeating: 0, count: 16)
    @Previewable @State var blueHistogram: [Int] = Array(repeating: 0, count: 16)
    
    return BarChartView(
        image: $sampleImage,
        numberOfBins: .constant(16),
        redHistogram: $redHistogram,
        greenHistogram: $greenHistogram,
        blueHistogram: $blueHistogram,
        name: "Histogram View",
        onApply: { }
    )
}
