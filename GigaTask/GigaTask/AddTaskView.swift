//
//  AddTaskView.swift
//  GigaTask
//
//

import Foundation
import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var name = ""
    @State private var content = ""
    @State private var showAlert = false
    


    var body: some View {
        NavigationView {
            Form {
                TextField("Task Name", text: $name)
                TextEditor(text: $content)
                    .frame(height: 200)
                Button(action: addTask) {
                    Text("Add Task")
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Task"),
                      message: Text("Task name and content cannot be empty."),
                      dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Add Task")
        }
    }

    func addTask() {
        if name.isEmpty || content.isEmpty {
            showAlert = true
        } else {
            let newTask = Task(context: managedObjectContext)
            newTask.id = UUID()
            newTask.name = name
            newTask.content = content
            newTask.isDone = false
            newTask.timestamp = Date()

            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }

            dismiss()
        }
    }
}
