//
//  ContentView.swift
//  Cosmic Planner
//
//  Created by Audrey Lucas on 6/23/24.
//

import SwiftUI
import CoreData


struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<TaskItem>

    var body: some View
    {
        NavigationView
        {
            VStack
            {
                ZStack
                {
                    List
                    {
                        ForEach(items)
                        { taskItem in
                            NavigationLink(destination: TaskEditView(passedTaskItem: taskItem, initialDate: Date())
                                .environmentObject(dateHolder))
                            {
                                 TaskCell(passedTaskItem: taskItem)
                                    .environmentObject(dateHolder)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                    }
                    
                    FloatingButton()
                        .environmentObject(dateHolder)
                }
            }.navigationTitle("Cosmic Planner")
        }
    }


    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            saveContext(viewContext)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
