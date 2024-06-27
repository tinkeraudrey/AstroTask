//
//  Cosmic_PlannerApp.swift
//  Cosmic Planner
//
//  Created by Audrey Lucas on 6/23/24.
//

import SwiftUI


struct Cosmic_PlannerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            
            let context = persistenceController.container.viewContext
            let dateHolder = DateHolder(context)
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dateHolder)
        }
    }
}
