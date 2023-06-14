//
//  GigaTaskApp.swift
//  GigaTask
//
//

import SwiftUI

@main
struct GigaTaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
