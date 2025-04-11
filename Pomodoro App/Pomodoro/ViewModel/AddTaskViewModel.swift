//
//  AddTaskViewModel.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import Foundation
import CoreData
import SwiftUI

class AddTaskViewModel: ObservableObject {
    @Published var name = ""
    @Published var description = ""
    @Published var priority = 1
    @Published var completed = false
    @Published var lat = 0.0
    @Published var lon = 0.0
    @Published var timeInMinutes = 0
    @Published var addedLocation = false

    func saveTask(context: NSManagedObjectContext, dismiss: () -> Void) {
        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.name = name
        newTask.descrip = description
        newTask.priority = Int16(priority)
        newTask.completed = completed
        newTask.timeInMinutes = Int16(timeInMinutes)
        newTask.lat = lat
        newTask.lon = lon

        try? context.save()
        dismiss()
    }
}
