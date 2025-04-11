//
//  SideBarView.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var appData: AppData
    var body: some View {
        TabView(selection: $appData.selectedTab) {
            PomodoroView()
                .tag(Tab.pomodoro)
                .tabItem {
                    Label("Pomodoro Timer", systemImage: "timer")
                }
            TaskView(viewModel: TaskViewModel())
                .tag(Tab.tasks)
                .tabItem {
                    Label("Tasks", systemImage: "checkmark.circle")
                }

        }
    }
}
