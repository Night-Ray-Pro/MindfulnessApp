//
//  DataSubDescriptionView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 5/12/24.
//

import SwiftUI

struct DataSubDescriptionView: View {
    var day: Day
    var body: some View {
        ZStack{
            Rectangle()
                .ignoresSafeArea()
                .settingsViewColor()
            ScrollView{
                Text("Data for \(day.dayIdentyfier)")
                    .foregroundStyle(.white)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .padding(.top, 15)
                Rectangle()
                    .foregroundStyle(Color.gray.opacity(0.5))
                    .frame(width: 300, height: 1)
                Group{
                    Text("Hours of sleep: ").font(.system(size: 16, weight: .bold, design: .rounded)) + Text("\(day.sleep)").font(.system(size: 16, weight: .medium, design: .default)).italic()
                    Text("Minutes of meditation: ").font(.system(size: 16, weight: .bold, design: .rounded)) + Text("\(day.meditation/60)").font(.system(size: 16, weight: .medium, design: .default)).italic()
                    Text("Cups of coffee: ").font(.system(size: 16, weight: .bold, design: .rounded)) + Text("\(day.coffee)").font(.system(size: 16, weight: .medium, design: .default)).italic()
                    Text("Quote's author: ").font(.system(size: 16, weight: .bold, design: .rounded)) + Text("\(day.author)").font(.system(size: 16, weight: .medium, design: .default)).italic()
                    Text("Quote of the day: ").font(.system(size: 16, weight: .bold, design: .rounded)) + Text("\"\(day.quote)\"").font(.system(size: 16, weight: .medium, design: .default)).italic()
                    Text("Mood: ").font(.system(size: 16, weight: .bold, design: .rounded)) + Text("\(day.mood)").font(.system(size: 16, weight: .medium, design: .default)).italic()
                    Text("Journal entries: ").font(.system(size: 16, weight: .bold, design: .rounded)) + Text("\(day.entries)").font(.system(size: 16, weight: .medium, design: .default)).italic()
                    Text("Moon phase: ").font(.system(size: 16, weight: .bold, design: .rounded)) + Text("\(day.moonPhase)").font(.system(size: 16, weight: .medium, design: .default)).italic()
                }
                .foregroundStyle(.white)
//                .font(.system(size: 16, weight: .bold, design: .rounded))
                .padding(.vertical, 5)
                .frame(width:300, alignment:.leading)
            }
//            List(weeks){ week in
//                Text(week.week)
//            }
        }
        .preferredColorScheme(.dark)
        
      
    }
}
//



//var weekDay: String




//var mood: Int
//var entries: Int
//var moonPhase: String
