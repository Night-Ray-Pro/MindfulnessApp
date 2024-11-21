//
//  TestView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 21/11/24.
//

import SwiftUI



struct TestView: View {
    @ObservedObject private var keyboardResponder = KeyboardResponder()
        @State private var text: String = ""
        
    var body: some View {
        VStack{
            ScrollViewReader { sp in
                ScrollView {
                    Text("hello")
                    TextEditor(text: $text)
                        .frame(height:100)
                        .background(.red)
                        .padding(.bottom, keyboardResponder.currentHeight)
                        .animation(.easeOut(duration: 0.3))
                        .id("TextEditor")
                        .onChange(of: text) { newValue in
                            sp.scrollTo("TextEditor", anchor: .bottom)
                        }
                }
            }
        }
    }
    }

    class KeyboardResponder: ObservableObject {
        @Published var currentHeight: CGFloat = 0
        var notificationCenter: NotificationCenter
        
        init(center: NotificationCenter = .default) {
            notificationCenter = center
            notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        @objc func keyBoardWillShow(notification: Notification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                currentHeight = keyboardSize.height
            }
        }

        @objc func keyBoardWillHide(notification: Notification) {
            currentHeight = 0
        }
    }


#Preview {
    TestView()
}
