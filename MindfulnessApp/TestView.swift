import SwiftUI

struct TestView: View {
    
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
        
    @State private var imageIsShowing = true
    @State private var firstText = "Wyjazd w góry Adding more text to see how it looks looks look slooks"
    @State private var secondText = "This is another text field.This is another text fieldThis is another text fieldThis is another text fieldThis is another text fieldThis is another text fieldThis is another text fieldThis is another text fieldThis is another text fieldThis is another text field"

    var body: some View {
        
//        VStack {
//            GeometryReader { geometry in
//                VStack(spacing: 5) { // Tight spacing between fields
//                    HStack{
//                        Text(weekDaysNames[weekDay])
//                            .foregroundStyle(dateColor)
//                            .font(.system(size: 18, weight: .bold, design: .rounded))
//                        Text(date.formatted(date: .abbreviated, time: .omitted))
//                            .foregroundStyle(.white)
//                            .font(.system(size: 18, weight: .medium, design: .rounded))
//                        Spacer()
//                        if locationName?.isEmpty == true || locationName != nil{
//                            Group{
//                                Text(locationName ?? "")
//                                //                            .background(.red)
//                                    .foregroundStyle(.gray.opacity(0.8))
//                                    .font(.system(size: 15, weight: .medium, design: .rounded))
//                                //                                .padding(5)
//                            }
//                            //                            .padding(10)
////                                .background(.purple)
//                        }
//                    }
//                    .padding(.horizontal)
//                    HStack{
//                        Spacer()
//                        Text(firstText)
//                            .foregroundStyle(.white)
//                            .font(.system(size:32))
//                            .multilineTextAlignment(.center)
//                            .lineLimit(nil)
//                            .padding()
//
//                        Spacer()
//                        
//                        if let data = imageData?.first,
//                            let uiimage = UIImage(data: data){
//                            Spacer()
//                            Image(uiImage: uiimage)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 142, height: 142)
//                                .clipShape(.rect(cornerRadius: 12))
//                                .overlay{
//                                    RoundedRectangle(cornerRadius: 12)
//                                        .stroke(dateColor, lineWidth: 2)
//                                }
//                        }
////
//                            
//                    }
//                    .frame(height:160)
//
//                    Text(secondText)
//                        .foregroundStyle(.white)
//                        .font(.system(size:12))
//                        .lineLimit(nil)
//                        .padding()
//                        .frame(maxWidth: .infinity, alignment: .leading) // Full width
//                }
//                .background{
//                    RoundedRectangle(cornerRadius: 10)
//                        .foregroundStyle(.black)
//                    
//                } // Common background for both texts
//                .frame(
//                    minHeight: 200, // Combined minimum height
//                    maxHeight: min(
//                        max(geometry.size.height, 200), 300 // Combined max height
//                    )
//                )
//            }
//            .frame(maxWidth: .infinity, maxHeight: 300) // Limit overall size
//            
//            Spacer()
//            
//            // Buttons to simulate longer text
//            VStack {
//                Button("Add More Text to First Field") {
//                    firstText += " Adding more text to the first field."
//                }
//                .padding()
//                
//                Button("Add More Text to Second Field") {
//                    secondText += " Adding more text to the second field."
//                }
//                .padding()
//            }
//        }
//        .padding()
        
     
                    VStack(spacing: 0) {
                        // First Text Field
                        HStack{
                            Text(weekDaysNames[weekDay])
                                .foregroundStyle(dateColor)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                            Text(date.formatted(date: .abbreviated, time: .omitted))
                                .foregroundStyle(.white)
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                            Spacer()
                            if locationName?.isEmpty == true || locationName != nil{
                               
                                    Text(locationName ?? "")
                                        .foregroundStyle(.gray.opacity(0.8))
                                        .font(.system(size: 12, weight: .medium, design: .rounded))

                                
                            }
                        }
                        .padding([.top, .horizontal])
                        .padding(.bottom, 15)
                        HStack{
                            Spacer()
                            Text(note.title)
                                .foregroundStyle(.white)
                                .font(.system(size: imageData!.isEmpty ? 36: 29, weight: .bold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .frame(height: dynamicHeight(size: 36, for: note.title, min: 50, max: 160))
//                                .padding()

                            Spacer()
                            
                            if let data = imageData?.first,
                                let uiimage = UIImage(data: data){
//                            if imageIsShowing{
//                                Spacer()
                                Image(uiImage: uiimage)
//                                Image(uiImage: UIImage(data:))
//                            image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 142, height: 142)
                                    .clipShape(.rect(cornerRadius: 12))
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(dateColor, lineWidth: 2)
                                    }
                            }
    //
                                
                        }
                        .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                            
                        
                        // Second Text Field
                        Text(note.content)
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundStyle(contentColor)
                            
                            .lineLimit(nil)
                            .padding(.horizontal)
                            .padding(.vertical)
//                            .font(.system(size:12))
                            .foregroundStyle(.white)
//                            .background(Color.gray.opacity(0.2))
//                            .frame(maxWidth: .infinity)
                            .frame(width: 353,height: dynamicHeight(size: 13, for: note.content, min: 50, max: 140), alignment: .leading)
                            .multilineTextAlignment(.leading)
//                            .background(.red)
                    }
                    

                    .frame(width:353)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.ultraThinMaterial)
                    }
                    .padding(.bottom,20)
                    
    
                
            }
            
            /// A function to calculate dynamic height for a text based on its content.
    private func dynamicHeight(size: Int, for text: String, min: CGFloat, max: CGFloat) -> CGFloat {
           let textSize = CGSize(width: UIScreen.main.bounds.width - 32, height: CGFloat.greatestFiniteMagnitude)
        let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(size))]
           let boundingRect = (text as NSString).boundingRect(
               with: textSize,
               options: .usesLineFragmentOrigin,
               attributes: textAttributes,
               context: nil
           )
           return Swift.min(Swift.max(boundingRect.height + 32, min), max) // Explicitly call Swift.min and Swift.max
       }
}

#Preview {
    TestView(note: JournalEntry(title: "Test title big", content: "Test BodyTestTest ", location: "Cracow"))
}
