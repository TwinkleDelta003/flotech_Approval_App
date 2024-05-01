import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> FlutterEntry {
        FlutterEntry(date: Date(), widgetData: WidgetData(text1: "0",text2: "0",text3: "0",text4: "0",text5: "0",text6: "0",text7: "0",text8: "0"))
        
    }

    func getSnapshot(in context: Context, completion: @escaping (FlutterEntry) -> ()) {
        let entry = FlutterEntry(date: Date(), widgetData: WidgetData(text1: "0",text2: "0",text3: "0",text4: "0",text5: "0",text6: "0",text7: "0",text8: "0"))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let sharedDefaults = UserDefaults.init(suiteName: "group.unnatiwidgets")
        let flutterData = try? JSONDecoder().decode(WidgetData.self, from: (sharedDefaults?
            .string(forKey: "widgetData")?.data(using: .utf8)) ?? Data())

        let entryDate = Calendar.current.date(byAdding: .hour, value: 24, to: Date())!
        let entry = FlutterEntry(date: entryDate, widgetData: flutterData)

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetData: Decodable, Hashable {
    let text1: String
    let text2: String
    let text3: String
    let text4: String
    let text5: String
    let text6: String
    let text7: String
    let text8: String
  
}

struct FlutterEntry: TimelineEntry {
    let date: Date
    let widgetData: WidgetData?
}
struct Unnati_WidgetsEntryView: View {
    var entry: Provider.Entry
    
    var percentage: Double {
        guard let text7 = Double(entry.widgetData?.text7 ?? "0"), let text8 = Double(entry.widgetData?.text8 ?? "1") else {
            return 0.0
        }
        return (text8 / text8 * 100.0) 
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 5) {
                Spacer().frame(height: 5)
                 
                
                HStack(alignment: .top, spacing: 10) {
                    ZStack {
           
                        Circle()
                            .stroke(lineWidth: 12)
                            .opacity(0.3)
                            .foregroundColor(Color.white)
                            .frame(width: 60, height: 60)
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(percentage / 100.0))
                            .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color.green)
                            .rotationEffect(Angle(degrees: 0.0))
                            .animation(.linear)
                            .frame(width: 60, height: 60)
                        
                        Text("\(Int(percentage))%")
                            .font(.system(size: 16))
                                 .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Your Approved Task")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text("\(entry.widgetData?.text7 ?? "0") / \(entry.widgetData?.text8 ?? "0")")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                         Spacer().frame(height: 10)
                        HStack {
                            CardView(title: "PO", count: "\(entry.widgetData?.text1 ?? "0") / \(entry.widgetData?.text2 ?? "0")")
                            CardView(title: "SO", count: "\(entry.widgetData?.text3 ?? "0") / \(entry.widgetData?.text4 ?? "0")")
                            CardView(title: "RO", count: "\(entry.widgetData?.text5 ?? "0") / \(entry.widgetData?.text6 ?? "0")")
                        }
                    }
                    .padding(.top, 10)
                    .padding(.trailing, 20)
                    
                    Spacer()
                }
            }
        }
    }


struct CardView: View {
    let title: String
    let count: String
    
    var body: some View { 
        VStack(spacing: 10) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(count)
                .font(.caption)
                .foregroundColor(.white)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 2)
        .frame(width: 60) // Increase the width of the card
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
    }
}

}





// Widgets Type 
struct Unnati_Widgets: Widget {
    let kind: String = "Unnati_Widgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Unnati_WidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Unnati 2.0 Widgets")
        .description("Choose your favourite widget")
        .supportedFamilies([.systemMedium])
    }
}
