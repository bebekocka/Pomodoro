//
//  TaskViewModel.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..

import Foundation
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var isShowingAddTaskView = false
    @Published var isShowingEditTask = false
    @Published var showComplete = false
}
