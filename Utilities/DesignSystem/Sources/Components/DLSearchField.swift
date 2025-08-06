//
// DLSearchField.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 14.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct DLSearchField: View {
    @Binding var text: String
    @FocusState var isFocused: Bool

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Constants.iconColor)
                .frame(width: 24, height: 22)

            TextField(text: $text) {
                Text(Constants.searchText)
                    .style(size: 17, weight: .regular, color: Constants.placeholderColor)
            }
            .focused($isFocused)

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Constants.iconColor)
                }
            }
        }
        .padding(.vertical, 7)
        .padding(.horizontal, 4)
        .background(Constants.textFieldBgColor, in: .rect(cornerRadius: 8))
    }
}

// MARK: - Preview

#Preview {
    DLSearchField(text: .constant(""))
        .padding(.horizontal)
}

// MARK: - Constants

private extension DLSearchField {

    enum Constants {
        static let searchText = String(localized: "search").capitalized
        // FIXME: iOS-3: Заменить на цвета DS
        static let iconColor = Color.secondary
        static let textFieldBgColor = Color.secondary.opacity(0.12)
        static let placeholderColor = Color.secondary.opacity(0.6)
        // -
    }
}
