//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import SwiftUI

@main
struct PomodoroApp: App {
    @StateObject private var dataController = DataController()
    @StateObject private var appData : AppData = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.colorScheme, .dark)
                .environmentObject(CounterModel())
                .environmentObject(appData)
                .onOpenURL { url in
                    let string = url.absoluteString.replacingOccurrences(of: "pomodoro://", with: "")
                    let components = string.components(separatedBy: "?")

                    for component in components {
                        if component.contains("tab=") {
                            let tabRawValue = component.replacingOccurrences(of: "tab=", with: "")
                            if let requestedTab = Tab.convert(from: tabRawValue) {
                                appData.selectedTab = requestedTab
                            }
                        }

                    }
                }
        }
    }
}
/*
struct mainView: View {
    var body: some View {
        NavigationView {
            SideBarView()
            Text("Select an item from the sidebar")
                .font(.largeTitle)
                .foregroundColor(.secondary)
        }
    }
}
*/
