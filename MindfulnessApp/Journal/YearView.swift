//
//  YearView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 30/11/24.
//

import SwiftData
import SwiftUI

struct YearView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [JournalEntry]
    @State private var selectedYear: Int
    @State private var isChoosingYear = false
    var searchString: String
    var years: [Int]
    
    init(searchString: String/*, notes: [JournalEntry]*/) {
        self.searchString = searchString
        let components = Calendar.current.dateComponents([.day, .year, .month], from: Date.now)
        self.selectedYear = components.year ?? 2024
//        var oldestYear = components.year ?? 3000
        
//        for note in notes{
//            if let year = note.year{
//                year < oldestYear ? (oldestYear = year) : nil
//            }
//        }
        
        years = []
        years = Array(2012...selectedYear).reversed()
//        years = Array(selectedYear ... oldestYear)
    }
    
    var body: some View {
        VStack{
            VStack(spacing:0){
                Group{
                    Button{
                        withAnimation{
                            isChoosingYear.toggle()
                        }
                    } label: {
                        Text(formatNumber(selectedYear))
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .foregroundStyle(.white)
                            .background{
                                
                                if isChoosingYear{
                                    Rectangle()
                                        .foregroundStyle(.gray.opacity(0.3))
                                }
                                
                            }
                            .overlay(alignment: .trailing) {
                                Image(systemName: "chevron.forward")
                                    .padding(.horizontal)
                                    .foregroundStyle(.white)
                                    .rotationEffect(Angle(degrees: isChoosingYear ? 90 : 0))
                            }
                    }
                    if isChoosingYear{
                        
                        ScrollView{
                            
                            ForEach(years, id: \.self){ year in
                                
                                year != years[0] ?
                                Rectangle()
                                    .foregroundStyle(.gray.opacity(0.3))
                                    .frame(width: 300, height: 1)
                                :
                                nil
                                //                            Text(formatNumber(year))
                                Button{
                                    withAnimation{
                                        selectedYear = year
                                        isChoosingYear = false
                                        
                                    }
                                } label: {
                                    Text(formatNumber(year))
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(5)
                                        .overlay(alignment: .trailing) {
                                            if year == selectedYear {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .padding(.horizontal)
                                                    .foregroundStyle(.white)
                                            }
                                            
                                        }
                                    //                                    .background(.blue)
                                }
                                
                                
                            }
                        }
                        .scrollIndicators(.hidden)
                        .padding(.bottom, 5)
                    }
                    
                }
                
            }
            .frame(width: 352, height: isChoosingYear ? 200 : 50)
            .background{
                Rectangle()
                    .foregroundStyle(.ultraThinMaterial)
                    .preferredColorScheme(.light)
                //                    .frame(width: 352, height: 50)
            }
            .clipShape(.rect(cornerRadius: 35))
            
            YearSubView(searchString: searchString, selectedYear: selectedYear)
            
            
            
            //        }
            
        }
        
    }
    private func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false // Disable thousand separators
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

#Preview {
    YearView(searchString: "Hihi"/*, notes: [JournalEntry()]*/)
}
