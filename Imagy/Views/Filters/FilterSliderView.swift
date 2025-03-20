//
//  FilterSliderView.swift
//  Imagy
//
//  Created by Pawel P on 15/03/2025.
//

import SwiftUI

struct IntegerFilterSliderView: View {
    @Binding var value: Int

    let title: String
    let description: String
    let range: ClosedRange<Int>
    let step: Int
    let onApply: () -> Void
    let onDisable: () -> Bool

    init(
        title: String,
        description: String = "",
        value: Binding<Int>,
        range: ClosedRange<Int>,
        step: Int = 1,
        onApply: @escaping () -> Void,
        onDisable: @escaping () -> Bool
    ) {
        self.title = title
        self.description = description
        self._value = value
        self.range = range
        self.step = step
        self.onApply = onApply
        self.onDisable = onDisable
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Spacer()

                Text(description)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            HStack {
                Slider(
                    value: Binding(
                        get: { Double(value) },
                        set: { value = Int($0) }
                    ),
                    in: Double(range.lowerBound)...Double(range.upperBound),
                    step: Double(step),
                    onEditingChanged: { isEditing in
                        if !isEditing {
                            onApply()
                        }
                    }
                )
                .disabled(onDisable())

                Text("\(value)")
                    .monospacedDigit()
                    .frame(width: 48)
                    .padding(6)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.background)
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct DoubleFilterSliderView: View {
    @Binding var value: Double

    let title: String
    let description: String
    let range: ClosedRange<Double>
    let step: Double
    let onApply: () -> Void
    let onDisable: () -> Bool

    init(
        title: String,
        description: String = "",
        value: Binding<Double>,
        range: ClosedRange<Double>,
        step: Double = 0.1,
        onApply: @escaping () -> Void,
        onDisable: @escaping () -> Bool
    ) {
        self.title = title
        self.description = description
        self._value = value
        self.range = range
        self.step = step
        self.onApply = onApply
        self.onDisable = onDisable
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Spacer()

                Text(description)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            HStack {
                Slider(
                    value: $value,
                    in: range,
                    step: step,
                    onEditingChanged: { isEditing in
                        if !isEditing {
                            onApply()
                        }
                    }
                )
                .disabled(onDisable())

                Text(String(format: "%.2f", value))
                    .monospacedDigit()
                    .frame(width: 60)
                    .padding(6)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.background)
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    @Previewable @State var integerValue: Int = 5
    @Previewable @State var doubleValue = 0.5

    VStack {
        IntegerFilterSliderView(
            title: "Integer Slider",
            value: $integerValue,
            range: 0...10,
            step: 1,
            onApply: {},
            onDisable: { false }
        )

        DoubleFilterSliderView(
            title: "Double Slider",
            value: $doubleValue,
            range: 0.1...1.1,
            step: 0.1,
            onApply: {},
            onDisable: { false }
        )
    }
}
