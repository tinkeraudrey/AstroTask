//
//  CheckBoxView.swift
//  Cosmic Planner
//
//  Created by Audrey Lucas on 6/24/24.
//

import SwiftUI

struct CheckBoxView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItem
    
    var body: some View {
        
        Image(systemName: passedTaskItem.isCompleted() ? "checkmark.circle.fill" : "circle")
            .foregroundColor(passedTaskItem.isCompleted() ? .purple.opacity(0.5) : .secondary)
            .onTapGesture {
                withAnimation
                {
                    if !passedTaskItem.isCompleted()
                    {
                        passedTaskItem.completedDate = Date()
                        dateHolder.saveContext(viewContext)
                    }
                }
            }
            
            
        
    }
}

struct CheckBoxVIew_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(passedTaskItem: TaskItem())
    }
}
