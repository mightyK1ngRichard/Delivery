//
// MainHeaderView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 14.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

public struct MainHeaderView: View {

    @Binding
    var textInput: String

    @FocusState
    private var isFocused: Bool

    public init(textInput: Binding<String>) {
        self._textInput = textInput
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DLIcon.logo.image
                .padding(.top, 15)

            DLSearchField(text: $textInput)
                .focused($isFocused)
                .padding(.top, 12)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MainHeaderView(textInput: .constant(""))
}
