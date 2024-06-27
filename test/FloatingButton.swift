//
//  FloatingButton.swift
//  Cosmic Planner
//
//  Created by Audrey Lucas on 6/23/24.
//

import SwiftUI

struct FloatingButton: View
{
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View
    {
        Spacer()
        HStack
        {
            NavigationLink(destination: TaskEditView(passedTaskItem:nil, initialDate: Date())
                .environmentObject(dateHolder))
            {
                Text("Task Initiation")
                    .font(.headline)
            }
            .padding(15)
            .foregroundColor(.black) 
            .background(.purple.opacity(0.5))
            .cornerRadius(30)
            .padding(30)
            .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
        }
    }
}
                        
            
        
                           
struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}
