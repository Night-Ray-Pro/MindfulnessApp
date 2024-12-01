import SwiftUI
import Charts

struct TestView: View {
    // Data model for each day
    struct SleepData: Identifiable {
        let id = UUID()
        let date: Date
        let hours: Double
    }

    // Example data for the month
    @State private var sleepData: [SleepData] = []
    @State private var visibleRange: ClosedRange<Int> = 0...6 // Default visible range

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // Short weekday name: Mon, Tue, etc.
        return formatter
    }()
    
    private let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    init() {
        // Populate data dynamically for the current month
        var data: [SleepData] = []
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        for offset in 0..<30 {
            if let date = calendar.date(byAdding: .day, value: offset, to: today) {
                data.append(SleepData(date: date, hours: Double.random(in: 5...9)))
            }
        }
        _sleepData = State(initialValue: data)
    }

    var body: some View {
        VStack {
            // Dynamic legend for visible range
            if let firstDate = visibleDays.first?.date, let lastDate = visibleDays.last?.date {
                Text("\(fullDateFormatter.string(from: firstDate)) - \(fullDateFormatter.string(from: lastDate))")
                    .font(.headline)
                    .padding()
            } else {
                Text("Scroll to see the range")
                    .font(.headline)
                    .padding()
            }

            // Chart with horizontal scrolling
            Chart(visibleDays) { data in
                BarMark(
                    x: .value("Day", dateFormatter.string(from: data.date)),
                    y: .value("Hours", data.hours)
                )
                .foregroundStyle(.blue)
            }
            .chartScrollableAxes(.horizontal)
//            .chartScrollPositionX(visibleRange.lowerBound)
            .chartXAxis {
                AxisMarks { value in
                    let index = value.index
                    if let date = visibleDays[safe: index]?.date {
                        AxisValueLabel(dateFormatter.string(from: date))
                    }
                }
            }
            .onChange(of: visibleRange) { _ in
                // Update legend dynamically
            }
            
            .frame(height: 300)

            Spacer()
        }
        .padding()
        .onAppear {
            // Set default visible range
            visibleRange = 0...min(6, sleepData.count - 1)
        }
    }

    // Calculate visible days based on the visible range
    private var visibleDays: [SleepData] {
        Array(sleepData[visibleRange])
    }
}

// Extension to safely access array elements
extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
#Preview {
    TestView()
}
