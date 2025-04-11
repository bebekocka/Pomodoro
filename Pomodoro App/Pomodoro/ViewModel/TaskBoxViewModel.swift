//
//  TaskBoxViewModel.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import Foundation
import SwiftUI
import CoreData

class TaskBoxViewModel: ObservableObject {
    @Published var isCompleted: Bool

    init(isCompleted: Bool) {
        self.isCompleted = isCompleted
    }

    func toggleCompletion(for task: Task, in context: NSManagedObjectContext) {
        withAnimation(.easeOut(duration: 1)) {
            isCompleted.toggle()
            task.completed = isCompleted
            try? context.save()
        }
    }
}
