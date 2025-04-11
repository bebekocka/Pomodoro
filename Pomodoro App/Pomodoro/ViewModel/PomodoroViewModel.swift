//
//  PomodoroViewModel.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 09..
//

import Foundation

class PomodoroViewModel: ObservableObject {
    @Published var restTime = 15
    @Published var workTime = 45
    @Published var isRunning = false
    @Published var currentTimer = 0
    @Published var remainingTime = 0
    @Published var isWorkTime = true
}
