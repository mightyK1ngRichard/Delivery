//
// ErrorView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

public struct ErrorView: View {

    let title: String
    let subtitle: String?
    var handler: DLVoidBlock?

    public init(
        title: String,
        subtitle: String? = nil,
        handler: DLVoidBlock? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.handler = handler
    }

    public var body: some View {
        ErrorView
    }
}

// MARK: - UI Subviews

private extension ErrorView {

    var ErrorView: some View {
        VStack(alignment: .leading, spacing: .SPx4) {
            ErrorTitle(title)
            if let subtitle {
                ErrorText(subtitle)
            }

            Spacer()

            HStack {
                DLBasketMakeOrderButton(
                    configuration: .init(
                        state: .default,
                        title: "Сообщить",
                        subtitle: "Опишите проблему",
                        isDisable: false
                    )
                )
                if let handler {
                    DLBasketMakeOrderButton(
                        configuration: .init(
                            state: .default,
                            title: "Обновить",
                            subtitle: "Повторите запрос",
                            isDisable: false
                        ),
                        didTapButton: handler
                    )
                }
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DLIcon.gradientBG.image)
    }

    func ErrorText(_ string: String) -> some View {
        Text(string)
            .style(size: 11, weight: .regular, color: DLColor<TextPalette>.gray800.color)
    }

    func ErrorTitle(_ title: String) -> some View {
        Text(title)
            .style(size: 17, weight: .heavy, color: DLColor<TextPalette>.primary.color)
    }
}
