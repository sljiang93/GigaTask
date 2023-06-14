//
//  PieChartView.swift
//  GigaTask
//
//

import Foundation
import SwiftUI

struct PieChartView: View {
    let doneTasks: Double
    let todoTasks: Double
    let tasks: FetchedResults<Task>

    var body: some View {
        VStack {
 
            let total = doneTasks + todoTasks

            let doneSlice = PieSliceData(id: 0, value: doneTasks, startAngle: .degrees(0), endAngle: .degrees(360 * doneTasks / total))
            let todoSlice = PieSliceData(id: 1, value: todoTasks, startAngle: doneSlice.endAngle, endAngle: .degrees(360))

            PieChart(slices: [doneSlice, todoSlice], colors: [Color.green, Color.red])

            Text("Pie Chart")
        }
        .navigationBarTitle("Pie Chart")
    }
}
