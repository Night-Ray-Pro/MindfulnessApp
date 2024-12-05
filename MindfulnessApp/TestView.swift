import SwiftUI

struct TestView: View {
    @State private var num = Measurement(value: 68, unit: UnitLength.centimeters)

    var body: some View {
        VStack {
            // Display formatted measurement
            Text(num, format: .measurement(width: .narrow, usage: .personHeight))
            
            // TextField for editing the measurement
            HStack(spacing:0){
                TextField(
                    "Enter height",
                    value: Binding(
                        get: { num.value },
                        set: { num = Measurement(value: $0, unit: .centimeters) }
                    ),
                    format: .number
                )
                .frame(width:100)
                .multilineTextAlignment(.trailing)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad) // Ensure numeric keyboard
                Text("cm")
            }
            
        }
        .padding()
    }
}

#Preview {
    TestView()
}
