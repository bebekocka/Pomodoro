//
//  TimeProgressView.swift
//  PomodoroProductivity
//
//  Created by Benjámin Kocka on 2024. 11. 09..
//

import SwiftUI
import UserNotifications

struct TimeProgressView: View {
    @StateObject private var viewModel: TimeProgressViewModel
    let timerColor: Color
    
    init(totalTime: Int, timerColor: Color, isRunning: Binding<Bool>, isWorkTime: Binding<Bool>) {
        self.timerColor = timerColor
        _viewModel = StateObject(wrappedValue: TimeProgressViewModel(totalTime: totalTime, isRunning: isRunning, isWorkTime: isWorkTime))
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .frame(width: 150, height: 150)
                .opacity(0.5)
                .foregroundColor(.gray)
                .shadow(color: .white.opacity(0.3), radius: 10, x: 10, y: 10)
            
            Circle()
                .trim(from: 0, to: viewModel.timeProgressValue)
                .stroke(style: StrokeStyle(lineWidth: 22, lineCap: .round))
                .frame(width: 150, height: 150)
                .rotationEffect(.degrees(-90))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [timerColor, .gray]), startPoint: .bottomTrailing, endPoint: .topLeading))
            
            Text(viewModel.formattedTime())
                .font(.largeTitle)
                .bold()
        }
        .onAppear {
            viewModel.start()
        }
    }
}

struct TimeIsNotRunning: View {
    let timerColor: Color
    let remainingTime: Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .frame(width: 150, height: 150)
                .opacity(0.5)
                .foregroundColor(.gray)
                .shadow(color: .white.opacity(0.3), radius: 10, x: 10, y: 10)
            
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 22, lineCap: .round))
                .frame(width: 150, height: 150)
                .rotationEffect(.degrees(-90))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [timerColor, .gray]), startPoint: .bottomTrailing, endPoint: .topLeading))
            
            Text(GlobalConstants.formattedTime(time: remainingTime))
                .font(.largeTitle)
                .bold()
        }
    }
}

#Preview {
    TimeProgressView(totalTime: 20, timerColor: Color(.green), isRunning: .constant(true), isWorkTime: .constant(false))
}
