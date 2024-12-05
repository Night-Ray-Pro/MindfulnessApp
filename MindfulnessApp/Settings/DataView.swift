//
//  DataView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 5/12/24.
//

import SwiftUI
import SwiftData

struct DataView: View {
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
    
    var body: some View {
        ZStack{
            Rectangle()
                .ignoresSafeArea()
                .settingsViewColor()
            ScrollView{
                Text("Weekly Data Collected")
                    .foregroundStyle(.white)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .padding(.top, 15)
                
                ForEach(weeks, id:\.week){ week in
                    Rectangle()
                        .foregroundStyle(Color.gray.opacity(0.5))
                        .frame(width: 300, height: 1)
                    NavigationLink{
                        DataSubView(week: week)
                            .toolbarBackground(.black.opacity(0.4), for: .navigationBar)
                            .toolbarBackground(.visible, for: .navigationBar)
                    } label:{
                        HStack{
                            Text(week.week)
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

#Preview {
    DataView()
}
