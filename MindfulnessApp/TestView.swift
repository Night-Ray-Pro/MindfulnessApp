import SwiftUI

struct TestView: View {
 
    enum sortorder: CaseIterable{
        case day, month, year
    }
    private var sorting = sortorder.day
    var body: some View {
        ForEach(sortorder.allCases, id: \.self){order in
            Text(String(describing: order))
        }
        Text("Hihi")
    }
   
}

#Preview {
    TestView()
}
