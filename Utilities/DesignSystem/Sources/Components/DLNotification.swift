//
// DLNotification.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

public struct DLNotification: View {

    private let text: String

    public init(text: String) {
        self.text = text
    }

    public var body: some View {
        HStack(spacing: 10) {
            DLIcon.warning.image

            Text(message)
                .style(size: 13, weight: .regular, color: DLColor<TextPalette>.primary.color)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(DLColor<BackgroundPalette>.orange.color, in: .rect(cornerRadius: 16))
    }

    private var message: AttributedString {
        var attributedString = AttributedString(text)
        if let range = attributedString.range(of: "добавить") {
            attributedString[range].foregroundColor = DLColor<TextPalette>.blue.color
        }
        if let range = attributedString.range(of: "«Личном кабинете»") {
            attributedString[range].foregroundColor = DLColor<TextPalette>.blue.color
        }
        return attributedString
    }
}
