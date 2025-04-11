//
//  PomodoroWidget.swift
//  PomodoroWidget
//
//  Created by Benjámin Kocka on 2024. 11. 29..
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

}

struct SimpleEntry: TimelineEntry {
    let date: Date
//    let startDate: Date
//    let endDate: Date
}

struct PomodoroWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Link(destination: URL(string: "pomodoro://tab=pomodoro")!) {
                Label("pomodoro", systemImage: "timer")
                    .padding()
                    .fontWeight(.bold)
                    .background(Color(red: 181 / 255, green: 131 / 255, blue: 76 / 255))
                    .cornerRadius(10)
            }
            Link(destination: URL(string: "pomodoro://tab=tasks")!) {
                Label("Tasks    ", systemImage: "checkmark.circle")

                    .padding()
                    .fontWeight(.bold)
                    .background(Color(red: 181 / 255, green: 131 / 255, blue: 76 / 255))
                    .cornerRadius(10)
            }
        }
    }
}

struct PomodoroWidget: Widget {
    let kind: String = "PomodoroWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                PomodoroWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                PomodoroWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Pomodoro Widget")
        .description("Widget for Pomodoro App with quick access to tasks and the Pomodoro timer.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    PomodoroWidget()
} timeline: {
    SimpleEntry(date: .now)
    SimpleEntry(date: .now)
}
