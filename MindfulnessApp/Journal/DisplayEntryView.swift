//
//  DisplayEntryView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 23/11/24.
//

import SwiftUI

struct DisplayEntryView: View {
    let note: JournalEntry
    let dateColor = Color(red: 188 / 255, green: 135 / 255, blue: 233 / 255)
    let contentColor = Color(red: 139 / 255, green: 101 / 255, blue: 207 / 255)
    let weekDaysNames = ["Sun", "Mon", "Tues", "Weds", "Thurs", "Fri", "Sat"]
    
    //
    
    let date: Date
    let weekDay: Int
    let title: String
    let locationName: String?
    let imageData: [Data]?
    let image = Image("testImage")
    let content: String
    
    init(note: JournalEntry) {
        self.note = note
        self.date = note.date
        self.weekDay = Calendar.current.component(.weekday, from: note.date) - 1
        self.title = note.title
        self.locationName = note.location
        self.content = note.content
        self.imageData = note.photoData
        
    }
    
    var body: some View {
        ZStack{
           
            VStack{
                HStack{
                    imageData == nil ? Spacer():nil
                    
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
//                            .frame(maxWidth: 322, maxHeight: 220, alignment: .topLeading)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .padding(.bottom,10)
//                            .padding(.vertical, title.count > 10 ? -20:5)
                            .background(.red)
//                            .frame(maxHeight: 130)
                       
                        VStack{
                            if locationName?.isEmpty == true || locationName != nil{
                                Group{
                                    Text(locationName ?? "")
                                    //                            .background(.red)
                                        .foregroundStyle(.gray.opacity(0.8))
                                        .font(.system(size: 15, weight: .medium, design: .rounded))
                                    //                                .padding(5)
                                }
                                //                            .padding(10)
                                .background(.purple)
                            }
                        }
                        .padding(.bottom, 10)
                            
                        
                    }
//                    .frame(maxHeight: 142)
//                    
                    
                    if let data = imageData?.first,
                        let uiimage = UIImage(data: data){
                        Spacer()
                        Image(uiImage: uiimage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 142, height: 142)
                            .clipShape(.rect(cornerRadius: 12))
                            .overlay{
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(dateColor, lineWidth: 2)
                            }
                    }
                    
                        
                }
                .background(.green)

//                Spacer()
                Text(content)
                    .frame(maxWidth: 322/*, maxHeight: 120*/, alignment: .topLeading)
                    .background(.red)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(contentColor)
                
            }
            .padding(10)
            
            
        }
        .frame(minWidth: 352)
        
        
        .background{
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.black)
                .preferredColorScheme(.light)
        }
        .frame(maxHeight: 293)
        
        .padding(.bottom, 20)
        
    }
}

#Preview {
    DisplayEntryView(note: JournalEntry(title: "Test TitleTest TitleTest TitleTest Title", content: "Test BodyTestTest ", location: "Cracow"))
}
