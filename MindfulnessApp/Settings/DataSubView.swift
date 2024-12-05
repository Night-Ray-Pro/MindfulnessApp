//
//  DataSubView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 5/12/24.
//

import SwiftUI

struct DataSubView: View {
    var week: ApplicationData
    var body: some View {
        ZStack{
            Rectangle()
                .ignoresSafeArea()
                .settingsViewColor()
            ScrollView{
                Text("Data for \(week.week)")
                    .foregroundStyle(.white)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .padding(.top, 15)
                
                ForEach(week.days, id:\.id){ day in
                    Rectangle()
                        .foregroundStyle(Color.gray.opacity(0.5))
                        .frame(width: 300, height: 1)
                    NavigationLink{
                        DataSubDescriptionView(day: day)
                            .toolbarBackground(.black.opacity(0.4), for: .navigationBar)
                            .toolbarBackground(.visible, for: .navigationBar)
                    } label:{
                        HStack{
                            Text("\(day.weekDay) \(day.dayIdentyfier)")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .padding(.horizontal, 15)
                                .padding(.vertical, 5)
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .padding(.trailing, 15)
                        }
                        .frame(width:300)
                            .overlay{
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white, lineWidth: 2)
                            }
                            .padding(.top, 10)
                    }
                   
                }
            }
//            List(weeks){ week in
//                Text(week.week)
//            }
        }
        .preferredColorScheme(.dark)
        
      
    }
}

//#Preview {
//    DataSubView()
//}
