//
//  TaskView.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import SwiftUI

struct TaskView: View {
    @StateObject var viewModel: TaskViewModel
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.priority, order: .reverse),
        SortDescriptor(\.timeInMinutes, order: .reverse),
    ]) var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(tasks.filter { $0.completed == viewModel.showComplete }) { task in
                        VStack(spacing: 16) {
                            HStack {
                                NavigationLink(destination: TaskDetailedView(task: task)) {
                                    
                                    TaskBoxView(task: task)
                                        .padding(8)
                                        .scrollTransition { content, phase in
                                            content
                                                .opacity(phase.isIdentity ? 1.0 : 0.2)
                                                .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                        }
                                    
                                }
                                
                                if viewModel.isShowingEditTask {
                                    Button(action:{
                                        moc.delete(task)
                                        try? moc.save()
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation {
                            viewModel.isShowingEditTask.toggle()
                        }
                        
                    }) {
                        Text(viewModel.isShowingEditTask ? "Done": "Edit")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.isShowingAddTaskView.toggle()
                    }) {
                        Label("Add Task", systemImage: "plus.circle")
                    }
                    .font(.headline)
                }
                ToolbarItem(placement: .bottomBar) {
                    withAnimation {
                        Picker("Filtered", selection: $viewModel.showComplete) {
                            Text("Incomplete").tag(false)
                            Text("Completed").tag(true)
                        }
                        .pickerStyle(.segmented)
                    }
                }
            }
            .popover(isPresented: $viewModel.isShowingAddTaskView){
                AddTaskView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    func deleteTask(at offsets: IndexSet) {
        for offset in offsets {
            let task = tasks[offset]
            moc.delete(task)
        }
        try? moc.save()
    }
}

#Preview {
    TaskView(viewModel: TaskViewModel())
}
