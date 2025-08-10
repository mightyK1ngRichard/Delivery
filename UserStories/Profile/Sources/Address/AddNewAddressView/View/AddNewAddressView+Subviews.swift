//
//  Created by Dmitriy Permyakov on 13.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DesignSystem

extension AddNewAddressView {

    var mainContainer: some View {
        ScrollView {
            VStack(spacing: .SPx8) {
                cellView(
                    title: "Название магазина",
                    placeholder: "Название",
                    text: $state.nameInput
                )

                cellView(
                    title: "Полный адрес",
                    placeholder: "Сюда доставят ваш заказ ",
                    text: $state.addressInput
                )

                // FIXME: Тут должен быть пикер
                cellView(
                    title: "Город",
                    placeholder: "Выберите город",
                    text: $state.cityInput
                )

                cellView(
                    title: "Улица",
                    placeholder: "Название",
                    text: $state.streetInput
                )

                cellView(
                    title: "Дом",
                    placeholder: "Номер",
                    text: $state.homeNumberInput
                )

                cellView(
                    title: "Квартира/Офис",
                    placeholder: "Номер",
                    text: $state.apartamentNumberInput
                )
            }
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .bottom) {
            sendButton
                .padding()
        }
    }
}

// MARK: - UI Subviews

private extension AddNewAddressView {

    func cellView(
        title: String,
        placeholder: String,
        text: Binding<String>
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .style(size: 13, weight: .semibold, color: Constants.textColor)

            inputView(placeholder: placeholder, text: text)
        }
    }

    func inputView(placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(DLColor<SeparatorPalette>.gray.color)
            }
    }

    var sendButton: some View {
        DLButton(
            configuration: .init(
                state: state.buttonState,
                hasDisabled: state.buttonIsDisabled,
                titleView: {
                    Text("Отправить")
                        .style(size: 16, weight: .semibold, color: Constants.textColor)
                },
                subtileView: { EmptyView() }
            ),
            action: {
                output.onTapSendButton()
            }
        )
    }
}

// MARK: - Constants

private extension AddNewAddressView {

    enum Constants {
        static let textColor = DLColor<TextPalette>.primary.color
    }
}
