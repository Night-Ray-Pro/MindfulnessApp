//
//  DisplayEntryView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 23/11/24.
//

import SwiftUI

struct DisplayEntryView: View {
    let dateColor = Color(red: 188 / 255, green: 135 / 255, blue: 233 / 255)
    let contentColor = Color(red: 139 / 255, green: 101 / 255, blue: 207 / 255)
    let date = Date.now
    let weekDay = Calendar.current.component(.weekday, from: Date.now) - 1
    let weekDaysNames = ["Sun", "Mon", "Tues", "Weds", "Thurs", "Fri", "Sat"]
    let title = "Long Testing Title"
    let locationName = "TestLocation"
    let image = Image("testImage")
    let content = "I found a quiet bench and watched as squirrels scampered up the trunks, their bushy tails twitching with excitement. A family of ducks waddled by, their tiny ducklings trailing behind. The serenity of the scene was truly captivating. As the sun began to set, casting long shadows across the park, I couldn't help but feel a sense of peace and gratitude for such a beautiful day."
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.ultraThinMaterial)
                .preferredColorScheme(.light)
            VStack{
                HStack{
                    Spacer()
                    VStack{
                        HStack{
                            Text(weekDaysNames[weekDay])
                                .foregroundStyle(dateColor)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                            Text(date.formatted(date: .abbreviated, time: .omitted))
                                .foregroundStyle(.white)
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                        }
//                        .background(.red)
//                        .padding(.bottom,3)
                        
                        Text(title)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .padding(.vertical, title.count > 10 ? 0:5)
//                            .background(.red)
//                            .frame(maxHeight: 130)
                       

                        
                        Text(locationName)
//                            .background(.red)
//                            .padding(.top,5)
                            .foregroundStyle(.gray.opacity(0.8))
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                    }
                    .frame(maxHeight: 142)
//                    
                    Spacer()
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 142, height: 142)
                        .clipShape(.rect(cornerRadius: 12))
                        .overlay{
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(dateColor, lineWidth: 2)
                        }
                }
                Spacer()
                Text(content)
                    .frame(maxWidth: 332, maxHeight: 120, alignment: .topLeading)
//                    .background(.red)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(contentColor)
                
            }
            .padding(10)
            
            
        }
        .frame(width: 352, height: 293)
        .padding(.bottom, 30)
    }
}

#Preview {
    DisplayEntryView()
}
