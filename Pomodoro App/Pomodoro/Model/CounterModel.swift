//
//  CounterModel.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 12. 03..
//

import Foundation
import SwiftUI
import Combine

class CounterModel: ObservableObject {
    @Published var counter: Int = 0
    @Published var isRunning: Bool = false
    var timer: Timer?


    private func startTimer() {
        timer?.invalidate()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.counter > 0 {
                self.counter -= 1
            } else {
                self.timer?.invalidate()
                withAnimation {
                    self.isRunning = false
                }
            }
        }
    }

    func setCounter(to value: Int){
        counter = value
        self.isRunning = true
        startTimer()
    }

    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
}
