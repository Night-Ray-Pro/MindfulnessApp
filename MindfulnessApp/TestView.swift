
import SwiftUI
import SwiftData


struct TestView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
    
    var currentWeekInterval: String {
        guard let interval = Calendar.current.dateInterval(of: .weekOfMonth, for: Date.now) else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        let startDate = formatter.string(from: interval.start)
        let endDate = formatter.string(from: interval.end)
        return "\(startDate) - \(endDate) \(Calendar.current.component(.year, from: Date.now))"
    }
    
    var currentDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: Date.now)
    }
    
    var currentDayShortName: String {
           let formatter = DateFormatter()
           formatter.dateFormat = "E" // Short form for day of the week
           return formatter.string(from: Date.now)
       }

    var body: some View {
        NavigationStack {
            Text("Current Week: \(currentWeekInterval)")
                .padding()
            
            Button("Add Week") {
                print(currentDayShortName)
                addCurrentWeek()
            }
            
            List(weeks) { week in
                NavigationLink(week.week){
                    VStack{
                        Text("Days:")
                        List(week.days){ day in
                            Text("\(day.dayIdentyfier)")
                        }
                    }
                }
            }
        }
        .onAppear{
            for week in weeks{
                modelContext.delete(week)
            }
        }
        .padding()
    }

    func addCurrentWeek() {
        let currentWeek = currentWeekInterval
        
        // Check if the week already exists
        if weeks.contains(where: { $0.week == currentWeek }) {
            print("Week already exists")
            
            if weeks.first!.days.contains(where: { $0.dayIdentyfier == currentDay}){
                print("Day in week already exists")
                return
            }
            
            let newDay = Day(dayIdentyfier: currentDay)
            weeks.first!.days.append(newDay)
            print("DayAdded")
            return
        }
        
        // Create and insert new ApplicationData
        let newWeek = ApplicationData(week: currentWeek)
        modelContext.insert(newWeek)
        try? modelContext.save()
        print("New week added: \(currentWeek)")
        let newDay = Day(dayIdentyfier: currentDay)
        weeks.first!.days.append(newDay)
        print("First Day Added \(currentDay)")
    }
}

#Preview {
    TestView()
}
