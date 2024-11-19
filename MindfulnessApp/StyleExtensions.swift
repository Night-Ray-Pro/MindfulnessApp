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

struct HomeDayViewGradient: ViewModifier {
    let gradientStart = Color(red: 239 / 255, green: 108 / 255, blue: 29 / 255)
    let gradientMiddle = Color(red: 255 / 255, green: 178 / 255, blue: 60 / 255)
    let gradientEnd = Color(red: 255 / 255, green: 212 / 255, blue: 159 / 255)

    func body(content: Content) -> some View {
        content
            .foregroundStyle(LinearGradient(stops: [
                Gradient.Stop(color: gradientStart, location: 0.0),
                Gradient.Stop(color: gradientMiddle, location: 0.60),
                Gradient.Stop(color: gradientEnd, location: 0.99),
            ], startPoint: .top, endPoint: .bottom))
    }
}

struct HomeNightViewGradient: ViewModifier {
    let gradientStart = Color(red: 68 / 255, green: 62 / 255, blue: 81 / 255)
    let gradientEnd = Color(red: 205 / 255, green: 101 / 255, blue: 98 / 255)

    func body(content: Content) -> some View {
        content
            .foregroundStyle(LinearGradient(stops: [
                Gradient.Stop(color: gradientStart, location: 0.10),
                Gradient.Stop(color: gradientEnd, location: 0.99),
            ], startPoint: .top, endPoint: .bottom))
    }
}

struct SettingsViewGradient: ViewModifier {
    let gradientStart = Color(red: 255 / 255, green: 132 / 255, blue: 61 / 255)
    let gradientMiddle = Color(red: 247 / 255, green: 139 / 255, blue: 77 / 255)
    let gradientEnd = Color(red: 75 / 255, green: 56 / 255, blue: 100 / 255)

    func body(content: Content) -> some View {
        content
            .foregroundStyle(LinearGradient(stops: [
                Gradient.Stop(color: gradientStart, location: 0.06),
                Gradient.Stop(color: gradientMiddle, location: 0.32),
                Gradient.Stop(color: gradientEnd, location: 0.99),
            ], startPoint: .top, endPoint: .bottom))
    }
}

struct SettingsViewColor: ViewModifier {
    let color = Color(red: 53 / 255, green: 48 / 255, blue: 72 / 255)

    func body(content: Content) -> some View {
        content
            .foregroundStyle(color)
    }
}

struct AddNoteGradient: ViewModifier {
    let gradientStart = Color(red: 216 / 255, green: 161 / 255, blue: 223 / 255)
    let gradientEnd = Color(red: 240 / 255, green: 210 / 255, blue: 244 / 255)

    func body(content: Content) -> some View {
        content
            .foregroundStyle(LinearGradient(stops: [
                Gradient.Stop(color: gradientStart, location: 0.01),
                Gradient.Stop(color: gradientEnd, location: 0.99),
            ], startPoint: .top, endPoint: .bottom))
    }
}

extension View {
    public func calculatorViewGradient() -> some View {
        self.modifier(CalculatorViewGradient())
    }
    
    public func homeDayViewGradient() -> some View {
        self.modifier(HomeDayViewGradient())
    }
    
    public func homeNightViewGradient() -> some View {
        self.modifier(HomeNightViewGradient())
    }
    public func settingsViewGradient() -> some View {
        self.modifier(SettingsViewGradient())
    }
    public func settingsViewColor() -> some View {
        self.modifier(SettingsViewColor())
    }
    public func addNoteGradient() -> some View {
        self.modifier(AddNoteGradient())
    }
}
