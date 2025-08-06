//
// MainHeaderView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 14.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct MainHeaderView: View {
    @Binding var textInput: String
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(.logo)
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
