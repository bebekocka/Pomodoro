//
//  TaskBoxView.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import SwiftUI

struct TaskBoxView: View {
    @Environment(\.managedObjectContext) var moc
    var task: Task
    @StateObject private var viewModel: TaskBoxViewModel
    
    
    init(task: Task) {
        self.task = task
        _viewModel = StateObject(wrappedValue: TaskBoxViewModel(isCompleted: task.completed))
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(task.name ?? "Untitled Task")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                
                VStack(alignment: .trailing) {
                    Button(action: {
                        viewModel.toggleCompletion(for: task, in: moc)
                    }) {
                        Image(systemName: viewModel.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(.secondary)
                            .contentTransition(.symbolEffect)
                            .font(.title)
                            .padding()
                    }
                    
                    Label(GlobalConstants.formattedTime(time: Int(task.timeInMinutes)), systemImage: "clock.fill")
                        .foregroundColor(.secondary)
                }
                
            }
            HStack {
                Text(task.descrip ?? "No description")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .font(.callout)
                    .lineLimit(2)
                
                Spacer()
                
                VStack{
                    switch task.priority {
                    case 1:
                        Text("Low")
                            .foregroundColor(.green)
                            .font(.caption)
                            .fontWeight(.light)
                    case 2:
                        Text("Medium")
                            .foregroundColor(.yellow)
                            .font(.caption)
                            .fontWeight(.medium)
                    case 3:
                        Text("High")
                            .foregroundColor(.red)
                            .font(.caption)
                            .fontWeight(.semibold)
                    default:
                        Text("Low")
                            .foregroundColor(.green)
                            .font(.caption)
                            .fontWeight(.light)
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .background(GlobalConstants.myColor)
        .cornerRadius(15)
        .shadow(color: .brown.opacity(0.3), radius: 1, x: 4, y: 4)
        .transition(.opacity)
    }
}

