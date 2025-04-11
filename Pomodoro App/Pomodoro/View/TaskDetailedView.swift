//
//  TaskDetailedView.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import SwiftUI

struct TaskDetailedView: View {
    var task: Task
    @StateObject private var viewModel = TaskDetailedViewModel()

    var body: some View {

            VStack {
                HStack {
                    Text(task.name ?? "Untitled Task")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(20)
                    Spacer()
                }
                
                Label(GlobalConstants.formattedTime(time: Int(task.timeInMinutes)), systemImage: "clock.fill")
                    .foregroundColor(.secondary)
                    .font(.title2)
                
                Spacer()
                
                HStack{
                    Text("Priority:")
                    Text(task.priority == 1 ? "Low" : task.priority == 2 ? "Medium" : "High")
                }
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .padding(20)
                
                Spacer()
                GroupBox {
                    ScrollView {
                        HStack {
                            Text(task.descrip ?? "No description")
                                .multilineTextAlignment(.leading)
                                .padding(5)
                                .scrollTransition { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1.0 : 0.01)
                                }
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.thinMaterial.opacity(0))
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.thinMaterial)
                .cornerRadius(20)
                .padding(.horizontal, 25)
                Spacer()
                
                if viewModel.isLocationVisible {
                    Button {
                        viewModel.isShowLocation.toggle()
                    } label: {
                        Label("Show Location", systemImage: "location.circle")
                    }
                    .buttonStyle(.bordered)
                    .contentShape(Rectangle())
                    .controlSize(.extraLarge)
                    .padding(5)
                } else {
                    Label("No available Location", systemImage: "location.slash")
                        .buttonStyle(.bordered)
                        .contentShape(Rectangle())
                        .controlSize(.extraLarge)
                        .padding(5)
                }
                
            }
            .background(Color.black)
            .sheet(isPresented: $viewModel.isShowLocation) {
                ZStack {
                    MapView(latitude: task.lat, longitude: task.lon)
                    
                    VStack {
                        Spacer()
                        Button(action: {
                            viewModel.isShowLocation.toggle()
                        }) {
                            Label("Close", systemImage: "xmark.circle.fill")
                                .foregroundColor(.red)
                                .padding(12)
                                .background(.thinMaterial.opacity(0.97),
                                            in: RoundedRectangle(cornerRadius: 20))
                        }
                        .padding()
                    }
                }
            }
            
            .onAppear {
                if task.lat != 0.0 && task.lon != 0.0 {
                    viewModel.isLocationVisible = true
                }
            }
        }

}


