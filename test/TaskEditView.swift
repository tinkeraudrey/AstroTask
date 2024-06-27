//
//  TaskEditView.swift
//  Cosmic Planner
//
//  Created by Audrey Lucas on 6/23/24.
//

import SwiftUI

struct TaskEditView: View 
{
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var selectedTaskItem: TaskItem?
    @State var name: String
    @State var desc: String
    @State var dueDate: Date
    @State var scheduleTime: Bool
    
    init(passedTaskItem: TaskItem?, initialDate:Date)
    {
        if let taskItem = passedTaskItem
        {
            _selectedTaskItem = State(initialValue: taskItem)
            _name = State(initialValue: taskItem.name ?? "")
            _desc = State(initialValue: taskItem.desc ?? "")
            _dueDate = State(initialValue: taskItem.dueDate ?? initialDate)
            _scheduleTime = State(initialValue: taskItem.scheduleTime)
        }
        else
        {
            _name = State(initialValue: "")
            _desc = State(initialValue: "")
            _dueDate = State(initialValue: initialDate)
            _scheduleTime = State(initialValue: false)
        }
    }
    
    var body: some View
    {
        Form
        {
            Section(header: Text("Mission"))
            {
                TextField("Task Identifier", text: $name)
                TextField("Objective", text: $desc)
            }
            
            Section(header: Text("Target"))
            {
                Toggle("Critical Time", isOn: $scheduleTime)
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                DatePicker("Mission Deadline", selection: $dueDate, displayedComponents: displayComps())
            }
            
            if selectedTaskItem?.isCompleted() ?? false
            {
                Section(header: Text("Accomplished"))
                {
                    Text(selectedTaskItem?.completedDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                        .foregroundColor(.purple)
                }
            }
            
            Section()
            {
                Button("Launch Mission", action: saveAction)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    func displayComps() -> DatePickerComponents
    {
        return scheduleTime ? [.hourAndMinute, .date] : [.date]
    }
    
    func saveAction()
    {
        withAnimation
        {
            if selectedTaskItem == nil
            {
                selectedTaskItem = TaskItem(context: viewContext)
            }
            
            selectedTaskItem?.created = Date()
            selectedTaskItem?.name = name
            selectedTaskItem?.dueDate = dueDate
            selectedTaskItem?.scheduleTime = scheduleTime
            
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct TaskEditView_Previews: PreviewProvider
{
    static var previews: some View {
        TaskEditView(passedTaskItem: TaskItem(), initialDate: Date())
    }
}
