// PomodoroLiveLiveActivity.swift
// PomodoroLive
//
// Created by Benjámin Kocka on 2024. 12. 11..

import ActivityKit
import WidgetKit
import SwiftUI



struct PomodoroLiveAttributes: ActivityAttributes {
    public typealias PomodoroLiveAttributes = ContentState

    public struct ContentState: Codable, Hashable {
        var remainingTime: Int
    }

    var timeProgressValue: Double
    var totalTime: Int
}

struct PomodoroLiveLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PomodoroLiveAttributes.self) { context in
            // Lock screen/banner UI goes here
            HStack {
                Text(formattedTime(remainingTime: context.state.remainingTime))
                    .padding()
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                ZStack {
                    Circle()
                        .stroke(lineWidth: 15)
                        .frame(width: 75, height: 75)
                        .opacity(0.5)
                        .foregroundColor(.gray)
                        .shadow(color: .white.opacity(0.3), radius: 5, x: 5, y: 5)

                    Circle()
                        .trim(from: 0, to: context.attributes.timeProgressValue)
                        .stroke(style: StrokeStyle(lineWidth: 16, lineCap: .round))
                        .frame(width: 75, height: 75)
                        .rotationEffect(.degrees(-90))
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .bottomTrailing, endPoint: .topLeading))
                }
                .padding()
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here. Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {

                }
                DynamicIslandExpandedRegion(.trailing) {

                }
                DynamicIslandExpandedRegion(.bottom) {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 15)
                            .frame(width: 75, height: 75)
                            .opacity(0.5)
                            .foregroundColor(.gray)
                            .shadow(color: .white.opacity(0.3), radius: 5, x: 5, y: 5)

                        Circle()
                            .trim(from: 0, to: context.attributes.timeProgressValue)
                            .stroke(style: StrokeStyle(lineWidth: 16, lineCap: .round))
                            .frame(width: 75, height: 75)
                            .rotationEffect(.degrees(-90))
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .bottomTrailing, endPoint: .topLeading))

                        Text(formattedTime(remainingTime: context.state.remainingTime))
                            .padding()
                            .fontWeight(.bold)

                    }
                    .padding()
                }
            } compactLeading: {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 5)
                        .frame(width: 20, height: 20)
                        .opacity(0.5)
                        .foregroundColor(.gray)
                        .shadow(color: .white.opacity(0.3), radius: 3, x: 3, y: 3)

                    Circle()
                        .trim(from: 0, to: context.attributes.timeProgressValue)
                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                        .frame(width: 20, height: 20)
                        .rotationEffect(.degrees(-90))
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .bottomTrailing, endPoint: .topLeading))

                }
                .padding()
            } compactTrailing: {
                Text(formattedTime(remainingTime: context.state.remainingTime))
            } minimal: {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 5)
                        .frame(width: 20, height: 20)
                        .opacity(0.5)
                        .foregroundColor(.gray)
                        .shadow(color: .white.opacity(0.3), radius: 3, x: 3, y: 3)

                    Circle()
                        .trim(from: 0, to: context.attributes.timeProgressValue)
                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                        .frame(width: 20, height: 20)
                        .rotationEffect(.degrees(-90))
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .bottomTrailing, endPoint: .topLeading))

                }
                .padding()
            }
            .widgetURL(URL(string: "pomodoro://tab=pomodoro"))
            .keylineTint(Color.red)
        }
    }

    func formattedTime(remainingTime: Int) -> String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}




