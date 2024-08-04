//
//  ChipsCellView.swift
//  sport-matcher
//
//  Created by Dawid on 28/07/2024.
//

import SwiftUI

struct ChipsButtonView: View {
    private let title: String
    private let font: UIFont
    private let titleHorizontalPadding: CGFloat
    @State private var isSelected = false
    private let onSelected: (Bool) -> Void
    
    init(
        title: String,
        font: UIFont,
        titleHorizontalPadding: CGFloat,
        onSelected: @escaping (Bool) -> Void
    ) {
        self.title = title
        self.font = font
        self.titleHorizontalPadding = titleHorizontalPadding
        self.onSelected = onSelected
    }
    
    var body: some View {
        Button {
            buttonSelected()
        } label: {
            ZStack {
                if isSelected {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.black)
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(.black, lineWidth: 1)
                }
                Text(title)
                    .foregroundStyle(getTitleForegroundStyle())
                    .font(Font(font))
                    .padding(.horizontal, titleHorizontalPadding)
            }
            .frame(height: 32)
        }
    }
    
    @MainActor
    private func getTitleForegroundStyle() -> Color {
        if isSelected {
            return .white
        } else {
            return .black
        }
    }
    
    @MainActor
    private func buttonSelected() {
        isSelected.toggle()
        onSelected(isSelected)
    }
}

//#Preview {
//    ChipsCellView()
//}
