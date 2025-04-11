//
//  TaskBoxForPomodoroView.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import SwiftUI

struct TaskBoxForPomodoroView: View {
    @Environment(\.managedObjectContext) var moc
    var task: Task
    @StateObject private var viewModel: TaskBoxViewModel
    let boxColor: Color
    
    init(task: Task, boxColor: Color) {
        self.task = task
        self.boxColor = boxColor
        _viewModel = StateObject(wrappedValue: TaskBoxViewModel(isCompleted: task.completed))
    }
    
    var body: some View {
        HStack {
            VStack(alignment: HorizontalAlignment.leading) {
                Text(task.name ?? "Untitled Task")
                    .font(.title3)
                    .lineLimit(1)
                    .fontWeight(.bold)
                    .padding(4)
                
                
                switch task.priority {
                case 1:
                    Text("Priority: Low")
                        .font(.caption)
                        .fontWeight(.light)
                        .padding()
                case 2:
                    Text("Priority: Medium")
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding()
                case 3:
                    Text("Priority: High")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding()
                default:
                    Text("Priority: Low")
                        .font(.caption)
                        .fontWeight(.light)
                        .padding()
                }
                
            }
            
            
            
            Spacer()
            
            
            VStack{
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
                    .font(.caption)
            }
        }
        .padding()
        .background(boxColor)
        .cornerRadius(15)
        .transition(.opacity)
        .padding()
    }
}
