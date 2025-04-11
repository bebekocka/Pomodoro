//
//  TimeProgressViewModel.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 09..
//

import SwiftUI
import UserNotifications

class TimeProgressViewModel: ObservableObject {
    private var timer: Timer?
    @Published var timeProgressValue: Double = 1.0
    @Published var remainingTime: Int
    let totalTime: Int
    @Binding var isRunning: Bool
    @Binding var isWorkTime: Bool
    
    init(totalTime: Int, isRunning: Binding<Bool>, isWorkTime: Binding<Bool>) {
        self.totalTime = totalTime
        self._isRunning = isRunning
        self._isWorkTime = isWorkTime
        self.remainingTime = totalTime
    }
    
    func start() {
        startTimer()
        startAnimation()
        scheduleNotification()
    }
    
    private func startAnimation() {
        withAnimation(.linear(duration: Double(totalTime))) {
            timeProgressValue = 0.0
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                timer.invalidate()
                self.timer = nil
                withAnimation {
                    self.isWorkTime.toggle()
                    self.isRunning = false
                }
            }
        }
    }
    
    private func scheduleNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if !success, let error = error {
                print(error.localizedDescription)
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = isWorkTime ? "Work time is over!" : "Rest time is over!"
        content.subtitle = isWorkTime ? "It's time to take a break" : "It's time to get back to work!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(totalTime), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func formattedTime() -> String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    deinit {
        timer?.invalidate()
    }
}
