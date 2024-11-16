//
//  StyleExtensions.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import Foundation
import SwiftUI

struct CalculatorViewGradient: ViewModifier {
    let gradientStart = Color(red: 173 / 255, green: 89 / 255, blue: 61 / 255)
    let gradientEnd = Color(red: 0 / 255, green: 41 / 255, blue: 71 / 255)

    func body(content: Content) -> some View {
        content
            .foregroundStyle(LinearGradient(stops: [
                Gradient.Stop(color: gradientStart, location: 0.30),
                Gradient.Stop(color: gradientEnd, location: 0.99),
            ], startPoint: .top, endPoint: .bottom))
    }
}

extension View {
    public func calculatorViewGradient() -> some View {
        self.modifier(CalculatorViewGradient())
    }
}
