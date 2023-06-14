//
//  TaskDetailView.swift
//  GigaTask
//
//

import Foundation
import SwiftUI

struct TaskDetailView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    var task: Task

    var body: some View {
        VStack {
            Text(task.name ?? "")
            Text(task.content ?? "")
            Button(action: {


                self.task.isDone.toggle()

                do {
                    try self.managedObjectContext.save()
                } catch {
                    print(error)
                }
            }) {
                Text("Mark as Done")
            }
        }
    }
}
