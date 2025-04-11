//
//  GlobalConstants.swift
//  Pomodoro
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import Foundation
import SwiftUI

struct GlobalConstants {
    static let myColor = Color(red: 181 / 255, green: 131 / 255, blue: 76 / 255)

    static func formattedTime(time: Int) -> String {
        let hours = time / 60
        let minutes = time % 60
        return String(format: "%02d:%02d", hours, minutes)
    }

}
