//
//  najia_home_widget.swift
//  najia_home_widget
//
//  Created by zvhir on 02/11/2023.
//

import WidgetKit
import SwiftUI

private let widgetGroupId = "group.najia_app_group"

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), zone: "A", prayerdb: "N/A", configuration: ConfigurationAppIntent())
    }
    
    // UNTUK PREVIEW ADD WIDGET
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        
        let data = UserDefaults.init(suiteName: widgetGroupId)
        return SimpleEntry(date: Date(), zone: data?.string(forKey: "zone") ?? "B", prayerdb: data?.string(forKey: "prayerDB") ?? "N/A", configuration: configuration)
    }
    
    // UNTUK LIVE WIDGET
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let data = UserDefaults.init(suiteName: widgetGroupId)
        
        let prayerString = data?.string(forKey: "prayerDB") ?? "[]"
        
        struct PrayerTime: Codable {
            let hijri: String
            let date: String
            let day: String
            let imsak: String
            let fajr: String
            let syuruk: String
            let dhuhr: String
            let asr: String
            let maghrib: String
            let isha: String
        }
        
        if let data = prayerString.data(using: .utf8) {
            if let prayerTimes = try? JSONDecoder().decode([PrayerTime].self, from: data) {
                let entry = SimpleEntry(date: Date(), zone: prayerTimes.first?.dhuhr ?? "Tiada", prayerdb: prayerString, configuration: configuration)
                return Timeline(entries: [entry], policy: .atEnd)
            } else {
                print("Error decoding JSON")
            }
        } else {
            print("Error converting JSON string to data")
        }
        
        let entry = SimpleEntry(date: Date(), zone: data?.string(forKey: "zone") ?? "N/A", prayerdb: data?.string(forKey: "prayerDB") ?? "N/A", configuration: configuration)
        return Timeline(entries: [entry], policy: .atEnd)
    }
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let zone: String
    let prayerdb: String
    let configuration: ConfigurationAppIntent
}

struct najia_home_widgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            SmallSizeView(entry: entry)
        case .systemMedium:
            MediumSizeView(entry: entry)
        case .systemLarge:
            LargeSizeView(entry: entry)
        default:
            Text("N/A")
        }
    }
}

struct najia_home_widget: Widget {
    let kind: String = "najia_home_widget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            najia_home_widgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies(
            [
                .systemSmall,
                .systemMedium,
                .systemLarge
            ]
        )
    }
}

func formatEntryDate(_ date: Date) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE d MMMM yyyy"
    dateFormatter.locale = Locale(identifier: "en_US")
    return dateFormatter.string(from: date)
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}
//
//#Preview(as: .systemSmall) {
//    najia_home_widget()
//} timeline: {
//    SimpleEntry(date: .now, zone: "C", prayerdb: "N/A", configuration: .smiley)
//    SimpleEntry(date: .now, zone: "N/A", prayerdb: "N/A", configuration: .starEyes)
//}
