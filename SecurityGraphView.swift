//
//  SecurityGraphView.swift
//  Fortune Teller
//
//  Created by E Martin on 4/6/24.
//

import Foundation
import SwiftUI


struct SecurityGraphView: View {
    var stockData: [StockDataPoint]

    @State private var isHovering = false
    @State private var hoveredDataPoint: StockDataPoint?

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Security Graph")

                if !stockData.isEmpty {
                    GraphContent(stockData: stockData, geometry: geometry, isHovering: $isHovering, hoveredDataPoint: $hoveredDataPoint)
                } else {
                    Text("No stock data available")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
        }
    }
}

struct GraphContent: View {
    var stockData: [StockDataPoint]
    var geometry: GeometryProxy
    @Binding var isHovering: Bool
    @Binding var hoveredDataPoint: StockDataPoint?

    var body: some View {
        ZStack(alignment: .topLeading) {
            graphPath
            dataPointCircles
            if let contentView = makeHoveredDataView() {
                contentView
                    .position(
                        x: min(geometry.size.width - 20, CGFloat(stockData.firstIndex { $0.date == hoveredDataPoint?.date && $0.adjustedClose == hoveredDataPoint?.adjustedClose } ?? 0) * geometry.size.width / CGFloat(stockData.count - 1)),
                        y: normalizedY(for: hoveredDataPoint?.adjustedClose ?? 0, in: geometry) - 50
                    )

            }
        }
        .frame(height: 200)
        .padding()
    }

    private var graphPath: some View {
        Path { path in
            for (index, dataPoint) in stockData.enumerated() {
                let x = CGFloat(index) / CGFloat(stockData.count - 1) * (geometry.size.width - 20)
                let y = normalizedY(for: dataPoint.adjustedClose, in: geometry)
                if index == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
        }
        .stroke(Color.blue, lineWidth: 2)
    }

    private var dataPointCircles: some View {
        ForEach(stockData.indices) { index in
            let dataPoint = stockData[index]
            let x = CGFloat(index) / CGFloat(stockData.count - 1) * (geometry.size.width - 20)
            let y = normalizedY(for: dataPoint.adjustedClose, in: geometry)

            Circle()
                .fill(Color.blue)
                .frame(width: 8, height: 8)
                .position(x: x, y: y)
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            hoveredDataPoint = dataPoint
                            isHovering = true
                        }
                )
        }
    }

    private func normalizedY(for value: Double, in geometry: GeometryProxy) -> CGFloat {
        guard !stockData.isEmpty else { return 0 }

        let minValue = stockData.map { $0.adjustedClose }.min() ?? 0
        let maxValue = stockData.map { $0.adjustedClose }.max() ?? 100

        // Ensure that the range is valid and non-zero
        guard maxValue > minValue else { return 0 }

        // Calculate the normalized value in the range [0, 1]
        let normalizedValue = (value - minValue) / (maxValue - minValue)

        // Scale the normalized value to fit within the available height (consider padding)
        let padding: CGFloat = 20 // Adjust padding as needed
        let scaledValue = normalizedValue * (geometry.size.height - padding)

        // Invert the scaled value to position the points correctly on the y-axis
        let yPosition = geometry.size.height - scaledValue

        return yPosition
    }



    private func makeHoveredDataView() -> AnyView? {
        guard isHovering, let dataPoint = hoveredDataPoint else {
            return nil
        }

        let contentView = VStack {
            Text("Date: \(formattedDate(dataPoint.date))")
            Text("Adjusted Close: \(String(format: "%.2f", dataPoint.adjustedClose))")
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(5)

        return AnyView(contentView)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}


extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}
