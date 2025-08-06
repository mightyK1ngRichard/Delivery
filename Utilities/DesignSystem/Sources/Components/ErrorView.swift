//
// ErrorView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 25.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    var error: APIError
    var fetchData: DLVoidBlock?

    init(error: APIError, fetchData: DLVoidBlock? = nil) {
        self.error = error
        self.fetchData = fetchData
    }

    init(message: String, fetchData: DLVoidBlock? = nil) {
        error = .customErrorText(message)
        self.fetchData = fetchData
    }

    var body: some View {
        ErrorView
    }
}

// MARK: - UI Subviews

private extension ErrorView {

    var ErrorView: some View {
        VStack(alignment: .leading, spacing: .SPx4) {
            switch error {
            case .invalidURL:
                ErrorTitle("Неверный URL")
            case .encodeError:
                ErrorTitle("Ошибка кодирования")
            case .invalidResponse:
                ErrorTitle("Ошибка ответа сервера")
            case .invalidData:
                ErrorTitle("Невалидные данные")
            case let .decodingError(error):
                ErrorTitle("Ошибка декодирования данных")
                ErrorText("\(error)")
            case let .error(error):
                ErrorTitle("Неизвестная ошибка")
                ErrorText("\(error)")
            case let .customErrorText(errorMessage):
                ErrorTitle("Неверный формат данных")
                ErrorText(errorMessage)
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
                if let fetchData {
                    DLBasketMakeOrderButton(
                        configuration: .init(
                            state: .default,
                            title: "Обновить",
                            subtitle: "Повторите запрос",
                            isDisable: false
                        ),
                        didTapButton: fetchData
                    )
                }
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image(.gradientBG))
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

// MARK: - Preview

#Preview {
    ScrollView {
        ErrorView(message: "Просто какая-то ошибка")
    }
}
