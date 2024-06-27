//
//  TaskItemExtension.swift
//  Cosmic Planner
//
//  Created by Audrey Lucas on 6/24/24.
//

import SwiftUI

extension TaskItem
{
    func isCompleted() -> Bool
    {
        return completedDate != nil
    }
}
