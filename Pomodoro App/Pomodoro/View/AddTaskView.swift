//
//  AddTaskView.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import SwiftUI

let backgroundGradient = LinearGradient(
    colors: [Color.black, Color.gray],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)

struct AddTaskView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showPopover = false
    @StateObject private var viewModel = AddTaskViewModel()
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .opacity(0.55)
                .ignoresSafeArea()
            
            VStack(spacing: 8){
                HStack{
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                    
                }
                HStack{
                    TextField("Task Name", text: $viewModel.name)
                        .autocorrectionDisabled()
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .background(Color.secondary)
                        .opacity(0.6)
                        .cornerRadius(10)
                    
                    Spacer()
                    HStack{
                        Image(systemName: "clock.fill")
                            .foregroundColor(.secondary)
                        
                        TextField("Minutes", value: $viewModel.timeInMinutes, formatter: NumberFormatter())
                            .foregroundColor(.secondary)
                            .font(.callout)
                            .fixedSize()
                            .background(Color.secondary.opacity(0.6))
                            .cornerRadius(10)
                    }
                }
                HStack{
                    TextField("Task Description:", text: $viewModel.description)
                        .autocorrectionDisabled()
                        .foregroundColor(.white)
                        .font(.callout)
                        .background(Color.secondary.opacity(0.6))
                        .cornerRadius(10)
                    
                    Spacer()
                    
                    Picker("TaskPriority", selection: $viewModel.priority) {
                        Text("Low").tag(1)
                        Text("Medium").tag(2)
                        Text("High").tag(3)
                    }
                    .pickerStyle(.segmented)
                }
                HStack{
                    
                    Button(action:{
                        showPopover = true
                    }){
                        Label(viewModel.addedLocation ? "Location Added" : "Add Location", systemImage: viewModel.addedLocation ? "checkmark.circle.fill" : "location.circle.fill" )
                            .foregroundColor(Color(viewModel.addedLocation ? .green : .white))
                    }
                    .buttonStyle(.bordered)
                    .contentShape(Rectangle())
                    .popover(isPresented: $showPopover){
                        SelectorMapView(lati: $viewModel.lat, longi: $viewModel.lon, addedLocation: $viewModel.addedLocation)
                    }
                    
                    
                    Spacer()
                    Button(action: {
                        viewModel.saveTask(context: moc) {
                            dismiss()
                        }
                    }) {
                        Text("Save")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .opacity(0.9)
                    }
                }
                
            }
            .padding()
            .background(GlobalConstants.myColor)
            .cornerRadius(15)
            .shadow(color: GlobalConstants.myColor, radius: 5)
            .padding()
        }
        .background(backgroundGradient)
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
