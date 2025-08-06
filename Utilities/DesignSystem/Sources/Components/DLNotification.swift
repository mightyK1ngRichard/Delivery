//
// DLNotification.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DLNotification: View {
    var text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(.warning)

            Text(message)
                .style(size: 13, weight: .regular, color: DLColor<TextPalette>.primary.color)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(DLColor<BackgroundPalette>.orange.color, in: .rect(cornerRadius: 16))
    }

    var message: AttributedString {
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

#Preview {
    DLNotification(text: "Вы должны добавить хотя бы один адрес доставки для оформления заказа.")
}
