//
//  DevoteAppWidget.swift
//  DevoteAppWidget
//
//  Created by Usha Sai Chintha on 21/09/22.
//

import WidgetKit
import SwiftUI

// TimelineProvider advises widgetkit when to update a widgets display
struct Provider: TimelineProvider {
    // placeholder function provides timeline entry that represents a placeholder version of widget
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    // getSnapshot function provides timeline entry that represents current time and state of widget
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    // getTimeline function provides an array of timeline entries for current timeand optionally any future times to update a widget
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
}

struct DevoteAppWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var widgetFamily
    
    var fontStyle: Font{
        if widgetFamily == .systemSmall {
            return .system(.footnote, design: .rounded)
        } else{
            return .system(.headline, design: .rounded)
        }
    }
    
    var body: some View {
//        Text(entry.date, style: .time)
        GeometryReader { geomentry in
            ZStack{
                backgroundGradient
                Image("rocket-small")
                    .resizable()
                    .scaledToFit()
                
                Image("logo")
                    .resizable()
                    .frame(
                        width: widgetFamily != .systemSmall ? 56 : 36,
                        height: widgetFamily != .systemSmall ? 56 : 36
                    )
                    .offset(
                        x: (geomentry.size.width / 2) - 20,
                        y: (geomentry.size.width / -2) + 20
                    )
                    .padding(.top, widgetFamily != .systemSmall ? 32 : 12)
                    .padding(.trailing, widgetFamily != .systemSmall ? 32 : 12)
                
                HStack {
                    Text("Just Do It!!!")
                        .foregroundColor(.white)
                        .font(fontStyle)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            Color(red: 0, green: 0, blue: 0, opacity: 0.5)
                                .blendMode(.overlay)
                        )
                    .clipShape(Capsule())
                    if widgetFamily != .systemSmall{
                        Spacer()
                    }
                }
                .padding()
                .offset(y: (geomentry.size.height / 2) - 24)
            }
        }
    }
}

@main
struct DevoteAppWidget: Widget {
    let kind: String = "DevoteAppWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DevoteAppWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct DevoteAppWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DevoteAppWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            DevoteAppWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            DevoteAppWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
