//
//  DateHolder.swift
//  Cosmic Planner
//
//  Created by Audrey Lucas on 6/23/24.
//

import SwiftUI
import CoreData

class DateHolder: ObservableObject
{
    init(_ context: NSManagedObjectContext){
        
    }
    
    func saveContext(_ context: NSManagedObjectContext)
    {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
 
