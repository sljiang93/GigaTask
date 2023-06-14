//
//  PieChart.swift
//  GigaTask
//
//

import Foundation
import SwiftUI

struct PieChart: View {
    var slices: [PieSliceData]
    var colors: [Color]
    
    var body: some View {
        GeometryReader { geometry in
            self.makePieChart(geometry: geometry)
        }
    }
    
    func makePieChart(geometry: GeometryProxy) -> some View {
        return ZStack {
            ForEach(slices) { slice in
                PieSlice(startAngle: slice.startAngle, endAngle: slice.endAngle)
                    .fill(self.colors[slice.id % self.colors.count])
            }
        }
    }
}

struct PieSliceData: Identifiable {
    var id: Int
    var value: Double
    var startAngle: Angle
    var endAngle: Angle
}
