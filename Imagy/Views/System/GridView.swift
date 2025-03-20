//
//  GridView.swift
//  Imagy
//
//  Created by Pawel P on 16/03/2025.
//

import SwiftUI

struct GridView: View {
    @Binding var kernel: [[Float]]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<kernel.count, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(0..<kernel.count, id: \.self) { col in
                        TextField(
                            "0.0",
                            value: self.$kernel[row][col],
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(PlainTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .frame(width: 50, height: 50)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                        .padding(2)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 16, weight: .medium))
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    @Previewable @State var kernel: [[Float]] = [
        [1.0, 0.0, -1.0],
        [2.0, 0.0, -2.0],
        [1.0, 0.0, -1.0]
    ]
    
    GridView(kernel: $kernel)
}
