import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    //@FetchRequest(entity: Task.entity(), sortDescriptors: []) var tasks: FetchedResults<Task>
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.timestamp, ascending: true)]) var tasks: FetchedResults<Task>
    @State private var isPresentingAddTaskView = false

    var doneTasks: Double {
        Double(tasks.filter { $0.isDone }.count)
    }

    var todoTasks: Double {
        Double(tasks.filter { !$0.isDone }.count)
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Text("To Do").bold()
                        List {
                            ForEach(tasks.filter { $0.isDone == false }) { task in
                                NavigationLink(destination: TaskDetailView(task: task)) {
                                    Text(task.name ?? "")
                                }
                            }
                            .onDelete(perform: deleteTask)
                        }
                    }
                    VStack {
                        Text("Done").bold()
                        List {
                            ForEach(tasks.filter { $0.isDone == true }) { task in
                                NavigationLink(destination: TaskDetailView(task: task)) {
                                    Text(task.name ?? "")
                                }
                            }
                            .onDelete(perform: deleteTask)
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()

                NavigationLink(destination: PieChartView(doneTasks: doneTasks, todoTasks: todoTasks, tasks: tasks)) {
                    Text("View Pie Chart")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingAddTaskView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddTaskView) {
                AddTaskView()
                    .environment(\.managedObjectContext, managedObjectContext)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) 
    }

    func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            managedObjectContext.delete(task)
        }

        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
