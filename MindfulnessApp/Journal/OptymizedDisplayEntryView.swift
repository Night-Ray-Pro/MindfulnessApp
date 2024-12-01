//
//  OptymizedDisplayEntryView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 1/12/24.
//

import SwiftUI

struct OptymizedDisplayEntryView: View {
    
    let note: JournalEntry
    
    // Static colors to avoid recreating
    static let dateColor = Color(red: 188 / 255, green: 135 / 255, blue: 233 / 255)
    static let contentColor = Color(red: 139 / 255, green: 101 / 255, blue: 207 / 255)
    static let weekDaysNames = ["Sun", "Mon", "Tues", "Weds", "Thurs", "Fri", "Sat"]
    
    // Precomputed properties
    let date: Date
    let weekDay: Int
    let title: String
    let locationName: String?
    let hasLocation: Bool
    let imageData: [Data]?
    let cachedImage: UIImage?
    let titleHeight: CGFloat
    let contentHeight: CGFloat
    
    init(note: JournalEntry) {
        self.note = note
        self.date = note.date
        self.weekDay = Calendar.current.component(.weekday, from: note.date) - 1
        self.title = note.title
        self.locationName = note.location
        self.hasLocation = !(note.location?.isEmpty ?? true)
        self.imageData = note.photoData
        
        // Precompute heights
        self.titleHeight = Self.dynamicHeight(size: 36, for: note.title, min: 50, max: 160)
        self.contentHeight = Self.dynamicHeight(size: 13, for: note.content, min: 50, max: 140)
        
        // Cache the first image resized
        if let data = note.photoData?.first {
            let targetSize = CGSize(width: 142, height: 142)
            self.cachedImage = Self.resizeImage(data: data, targetSize: targetSize)
        } else {
            self.cachedImage = nil
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // First Text Field
            HStack {
                Text(Self.weekDaysNames[weekDay])
                    .foregroundStyle(Self.dateColor)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                Text(date.formatted(date: .abbreviated, time: .omitted))
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                Spacer()
                if hasLocation {
                    Text(locationName ?? "")
                        .foregroundStyle(.gray.opacity(0.8))
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                }
            }
            .padding([.top, .horizontal])
            .padding(.bottom, 15)
            
            HStack {
                Spacer()
                Text(note.title)
                    .foregroundStyle(.white)
                    .font(.system(size: imageData!.isEmpty ? 36 : 29, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .frame(height: titleHeight)
                Spacer()
                
                if let cachedImage {
                    Image(uiImage: cachedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 142, height: 142)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Self.dateColor, lineWidth: 2)
                        }
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            
            // Second Text Field
            Text(note.content)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundStyle(Self.contentColor)
                .lineLimit(nil)
                .padding(.horizontal)
                .padding(.vertical)
                .foregroundStyle(.white)
                .frame(width: 353, height: contentHeight, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .frame(width: 353)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.ultraThinMaterial)
        }
        .padding(.bottom, 20)
    }
    
    /// A function to calculate dynamic height for a text based on its content.
    static func dynamicHeight(size: Int, for text: String, min: CGFloat, max: CGFloat) -> CGFloat {
        let textSize = CGSize(width: UIScreen.main.bounds.width - 32, height: CGFloat.greatestFiniteMagnitude)
        let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(size))]
        let boundingRect = (text as NSString).boundingRect(
            with: textSize,
            options: .usesLineFragmentOrigin,
            attributes: textAttributes,
            context: nil
        )
        return Swift.min(Swift.max(boundingRect.height + 32, min), max)
    }
    
    /// A function to resize an image to a target size.
    static func resizeImage(data: Data, targetSize: CGSize) -> UIImage? {
        guard let image = UIImage(data: data) else { return nil }
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}

#Preview {
    OptymizedDisplayEntryView(note: JournalEntry(
        title: "Test title big",
        content: "Test BodyTestTest ",
        date: Date(),
        location: "Cracow",
        photoData: []
    ))
}

