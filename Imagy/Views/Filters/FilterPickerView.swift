import SwiftUI

struct FilterPickerView: View {
    static var filters: [String] {
        [
            "Choose a filter...",
            AveragingFilter.name,
            BinaryFilter.name,
            BrightnessFilter.name,
            ContrastFilter.name,
            CustomKernelFilter.name,
            EmbossFilter.name,
            FilmGrainFilter.name,
            GaussianFilter.name,
            GlitchFilter.name,
            GrayscaleFilter.name,
            MosaicFilter.name,
            NegativeFilter.name,
            PosterizeFilter.name,
            RobertsCrossFilter.name,
            SaturationFilter.name,
            SepiaFilter.name,
            SharpeningFilter.name,
            SobelFilter.name,
            VignetteFilter.name
        ]
    }

    @Binding var selectedFilter: String
    @Binding var modelData: ModelData
    @Binding var applyingFilter: Bool
    @Binding var selectedFilterView: (any FilterViewProtocol)?
    
    let onApply: () -> Void
    let onDisable: () -> Bool
    
    @State private var selectedFilterViewAny: AnyView = AnyView(Text("Choose a filter..."))

    private func updateFilterView() {
        let filterView: any FilterViewProtocol = switch selectedFilter {
        case AveragingFilter.name:
            AveragingFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case BinaryFilter.name:
            BinaryFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case BrightnessFilter.name:
            BrightnessFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case ContrastFilter.name:
            ContrastFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case CustomKernelFilter.name:
            CustomKernelFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case EmbossFilter.name:
            EmbossFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case FilmGrainFilter.name:
            FilmGrainFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case GaussianFilter.name:
            GaussianFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case GlitchFilter.name:
            GlitchFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case GrayscaleFilter.name:
            GrayscaleFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case MosaicFilter.name:
            MosaicFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case NegativeFilter.name:
            NegativeFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case PosterizeFilter.name:
            PosterizeFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case RobertsCrossFilter.name:
            RobertsCrossFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case SaturationFilter.name:
            SaturationFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case SepiaFilter.name:
            SepiaFilterVIew(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case SharpeningFilter.name:
            SharpeningFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case SobelFilter.name:
            SobelFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        case VignetteFilter.name:
            VignetteFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        default:
            EmptyFilterView(modelData: $modelData, applyingFilter: $applyingFilter, onDisable: onDisable)
        }
        selectedFilterViewAny = AnyView(filterView)
        selectedFilterView = filterView
    }
    
    var body: some View {
        VStack (spacing: 20){
            HStack {
                Image(systemName: "camera.filters")
                    .foregroundColor(.blue)
                
                Picker("Select a Filter", selection: $selectedFilter) {
                    ForEach(Self.filters, id: \.self) { filter in
                        Text(filter).tag(filter)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .disabled(onDisable())
                .onChange(of: selectedFilter) { _, _ in
                    updateFilterView()
                    onApply()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))

            selectedFilterViewAny
            .frame(maxWidth: .infinity)
        }
        .onAppear(perform: updateFilterView)
    }
}

#Preview {
    @Previewable @State var modelData = ModelData()
    @Previewable @State var selectedFilterView: (any FilterViewProtocol)?
    
    FilterPickerView(
        selectedFilter: .constant(AveragingFilter.name),
        modelData: $modelData,
        applyingFilter: .constant(false),
        selectedFilterView: $selectedFilterView,
        onApply: { } ,
        onDisable: { false }
    )
}
