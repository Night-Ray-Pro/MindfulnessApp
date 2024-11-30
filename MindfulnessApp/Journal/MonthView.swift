import SwiftData
import SwiftUI

struct MonthView: View {

    @State private var selectedMonth: Int
    @State private var isChoosingMonth = false
    @State private var chosenMonth: String
    var searchString: String
    let months = [
        "January", "February", "March", "April",
        "May", "June", "July", "August",
        "September", "October", "November", "December"
    ]
    
    init(searchString: String) {
        self.searchString = searchString
        let components = Calendar.current.dateComponents([.day, .year, .month], from: Date.now)
        self.chosenMonth = months[(components.month ?? 0) - 1]
        self.selectedMonth = components.month ?? 0
        
    }
    
    var body: some View {

        VStack(spacing:0){
                Group{
                    Button{
                        withAnimation{
                            isChoosingMonth.toggle()
                        }
                    } label: {
                        Text(chosenMonth)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .foregroundStyle(.white)
                            .background{
                                
                                if isChoosingMonth{
                                    Rectangle()
                                        .foregroundStyle(.gray.opacity(0.3))
                                }
                                
                            }
                            .overlay(alignment: .trailing) {
                                Image(systemName: "chevron.forward")
                                    .padding(.horizontal)
                                    .foregroundStyle(.white)
                                    .rotationEffect(Angle(degrees: isChoosingMonth ? 90 : 0))
                            }
                    }
                    if isChoosingMonth{
                        ScrollView{
                            ForEach(months, id: \.self){ month in
                                month != "January" ?
                                Rectangle()
                                    .foregroundStyle(.gray.opacity(0.3))
                                    .frame(width: 300, height: 1)
                                :
                                nil
                                Button{
                                    withAnimation{
                                        chosenMonth = month
                                        isChoosingMonth = false
                                        selectedMonth = months.firstIndex(of: month)! + 1
                                        print(selectedMonth)
                                    }
                                } label: {
                                    Text(month)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(5)
                                        .overlay(alignment: .trailing) {
                                            if month == chosenMonth {
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
        .frame(width: 352, height: isChoosingMonth ? 200 : 50)
            .background{
                Rectangle()
                    .foregroundStyle(.ultraThinMaterial)
                    .preferredColorScheme(.light)
//                    .frame(width: 352, height: 50)
            }
            .clipShape(.rect(cornerRadius: 35))
        
        MonthSubView(searchString: searchString, selectedMonth: selectedMonth)
            
            
            
//        }
        

        
    }
    
  

}

#Preview {
    MonthView(searchString: "hihi")
}
