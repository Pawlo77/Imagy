//
//  ContentView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI
import Photos

struct ContentView: View {
    @Binding var modelData: ModelData
    
    @State private var applyingFilter: Bool = false
    @State private var calculatingOriginalHistogram: Bool = false
    @State private var calculatingProcessedHistogram: Bool = false
    @State private var calculatingOriginalProjections: Bool = false
    @State private var calculatingProcessedProjections: Bool = false
    
    @State private var selectedFilter: String = "Choose a filter..."
    @State private var selectedFilterView: (any FilterViewProtocol)?
    
    @State private var selectedTab = 1
    
    @State private var numberOfBins: Int = 50
    @State private var numberOfBinsRaw: Int = 50
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                
                ZStack {
                    VStack {
                        FilterPickerView(
                            selectedFilter: $selectedFilter,
                            modelData: $modelData,
                            applyingFilter: $applyingFilter,
                            selectedFilterView: $selectedFilterView,
                            onApply: applyFilters,
                            onDisable: disable
                        )
                        
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        
                        Button(action: reset) {
                            Text("Reset Filters")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                        }
                        .disabled(disable())
                        .padding(.bottom)
                    }
                }
                .padding(.horizontal)
                .tabItem {
                    Label("Filters", systemImage: "slider.horizontal.3")
                }
                .tag(0)
                
                ZStack {
                    VStack {
                        ScrollView {
                            PhotoPickerView(
                                modelData: $modelData,
                                onLoadImage: loadImage
                            )
                            PhotoView(image: $modelData.processedImage, name: "Processed Image")
                            Spacer()
                        }
                        
                        Button(action: saveProcessedImage) {
                            Text("Save Processed Image")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                        }
                        .disabled(disable())
                        .padding(.bottom)
                    }
                }
                .padding(.horizontal)
                .tabItem {
                    Label("Photos", systemImage: "photo")
                }
                .tag(1)
                
                FullHeightVStack {
                    HistogramView(
                        image: $modelData.originalImage,
                        calculatingHistogram: $calculatingOriginalHistogram,
                        numberOfBins: $numberOfBins,
                        name: "Original image"
                    )
                    HistogramView(
                        image: $modelData.processedImage,
                        calculatingHistogram: $calculatingProcessedHistogram,
                        numberOfBins: $numberOfBins,
                        name: "Processed image"
                    )
                    IntegerFilterSliderView(
                        title: "Number of bins",
                        value: $numberOfBinsRaw,
                        range: 1...256,
                        step: 1,
                        onApply: {
                            () -> Void in
                            numberOfBins = numberOfBinsRaw
                        },
                        onDisable: disable
                    )
                }
                .tabItem {
                    Label("Histograms", systemImage: "chart.bar")
                }
                .tag(2)
                
                FullHeightVStack {
                    ProjectionView(
                        image: $modelData.originalImage,
                        calculatingProjection: $calculatingOriginalProjections,
                        name: "Original image"
                    )
                    ProjectionView(
                        image: $modelData.processedImage,
                        calculatingProjection: $calculatingProcessedProjections,
                        name: "Processed image"
                    )
                }
                .tabItem {
                    Label("Projections", systemImage: "square.grid.2x2")
                }
                .tag(3)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Imagy")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    func reset() {
        modelData.processedImage = modelData.originalImage
        selectedFilter = "Choose a filter..."
    }
    
    func loadImage(image: UIImage?) {
        applyFilters()
    }
    
    func applyFilters() {
        selectedFilterView?.apply()
    }
    
    func disable() -> Bool {
        return modelData.originalImage == nil || applyingFilter || calculatingOriginalHistogram || calculatingOriginalHistogram || calculatingOriginalProjections || calculatingProcessedProjections
    }
    
    func saveProcessedImage() {
        guard let processedImage = modelData.processedImage else {
            print("No processed image to save.")
            return
        }
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    
    ContentView(
        modelData: $modelData
    )
}
