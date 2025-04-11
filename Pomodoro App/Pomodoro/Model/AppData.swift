//
//  AppData.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 12. 02..
//

import SwiftUI

class AppData: ObservableObject {
    @Published var selectedTab: Tab = .pomodoro
}
