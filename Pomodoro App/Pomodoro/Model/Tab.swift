//
//  Tab.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 12. 02..
//

import SwiftUI

enum Tab: String, CaseIterable {
    case pomodoro = "Pomodoro"
    case tasks = "Tasks"
    
    static func convert(from: String) ->Self?{
        return Tab.allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}
