//
//  PomodoroView.swift
//  PomodoroProductivity
//
//  Created by Benjámin Kocka on 2024. 11. 09..
//

import SwiftUI
import UserNotifications

struct PomodoroView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.priority, order: .reverse),
        SortDescriptor(\.timeInMinutes, order: .reverse),
    ]) var tasks: FetchedResults<Task>
    
    @StateObject private var viewModel = PomodoroViewModel()
    
    var body: some View {
        portraitView
    }
    
    var portraitView: some View {
        VStack{
            if viewModel.isRunning {
                TimeProgressView(totalTime: viewModel.isWorkTime ? viewModel.workTime * 60 : viewModel.restTime * 60, timerColor: viewModel.isWorkTime ? GlobalConstants.myColor : .green, isRunning: $viewModel.isRunning, isWorkTime: $viewModel.isWorkTime)
                    .padding()
            } else {
                TimeIsNotRunning(timerColor: viewModel.isWorkTime ? GlobalConstants.myColor : .green, remainingTime: viewModel.isWorkTime ? viewModel.workTime * 60 : viewModel.restTime * 60)
                    .padding()
            }
            
            Spacer()
            
            Button(action: {
                withAnimation(.easeInOut){
                    if !viewModel.isRunning {
                        viewModel.isWorkTime.toggle()
                    }
                }
            }){
                Image(systemName: viewModel.isWorkTime ? "briefcase.fill" : "leaf.fill")
                    .font(.largeTitle)
                    .shadow(color: .gray.opacity(0.2), radius: 0.2, x: 6, y: 6)
                    .foregroundColor(viewModel.isWorkTime ? GlobalConstants.myColor : .green)
                    .contentTransition(.symbolEffect)
            }
            
            Spacer()
            
            if viewModel.isRunning == false {
                timeAdderView(time: viewModel.isWorkTime ? $viewModel.workTime : $viewModel.restTime, timeChange: viewModel.isWorkTime ? 5 : 1, color: viewModel.isWorkTime ? GlobalConstants.myColor : .green)
            }
            
            Spacer()
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(tasks.filter { $0.completed == false }) { task in
                        TaskBoxForPomodoroView(task: task, boxColor: viewModel.isWorkTime ? GlobalConstants.myColor : .green)
                            .containerRelativeFrame(.horizontal, count: 1, spacing: 8)
                            .scrollTransition { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.2)
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(8, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.visible)
            
            Button(action: {
                if viewModel.isRunning {
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                }
                withAnimation{
                    viewModel.isRunning.toggle()
                }
            }){
                Label(viewModel.isRunning ? "Stop" : "Start", systemImage: viewModel.isRunning ? "stop.fill" : "play.fill")
                    .contentTransition(.symbolEffect)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.isWorkTime ? GlobalConstants.myColor : .green)
                    .padding(7)
            }
            .buttonStyle(.bordered)
            .cornerRadius(50)
            .padding()
        }
    }
}

struct timeAdderView: View{
    @Binding var time: Int
    var timeChange: Int
    var color: Color
    
    var body: some View {
        HStack{
            Button(action: {
                if time > 5 {
                    time -= timeChange
                }
            }){
                Image(systemName: "arrowtriangle.down.circle.fill")
                    .foregroundStyle(Color(time == 5 ? .gray : color))
            }
            .padding()
            
            Text(GlobalConstants.formattedTime(time: time))
                .fontWeight(.bold)
            
            Button(action: {
                if time < 60 {
                    time += timeChange
                }
            }){
                Image(systemName: "arrowtriangle.up.circle.fill")
                    .foregroundStyle(Color(time == 60 ? .gray : color))
            }
            .padding()
        }
        .font(.title3)
        .background(.thinMaterial)
        .clipShape(Capsule())
    }
}
