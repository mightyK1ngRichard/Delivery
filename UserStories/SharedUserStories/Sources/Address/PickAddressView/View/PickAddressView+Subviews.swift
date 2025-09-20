//
//  Created by Dmitriy Permyakov on 13.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DesignSystem

extension PickAddressScreenView {

    var mainContainer: some View {
        ScrollView {
            switch state.state {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .error:
                ErrorView(title: "Ошибка получения данных", handler: output.onTapReloadButton)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .content:
                content
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Constants.navigationTitle)
    }
}

// MARK: - UI Subviews

private extension PickAddressScreenView {

    var content: some View {
        VStack(spacing: 0) {
            ForEach(state.addresses) { address in
                addressCellView(address: address)
            }

            addNewAddressButton
        }
        .padding(.horizontal)
    }

    func addressCellView(address: Address) -> some View {
        Button {
            guard state.selectedAddressID != address.id else { return }
            output.onPickAddress(address: address)
        } label: {
            HStack(spacing: 16) {
                DLCheckbox(
                    configuration: .init(
                        isSelected: state.selectedAddressID == address.id
                    )
                )

                Text(address.title)
                    .style(size: 17, weight: .regular, color: Constants.textColor)

                Spacer()
            }
        }
        .padding(.vertical, 17)
        .overlay(alignment: .bottom) {
            Divider()
        }
    }

    var addNewAddressButton: some View {
        Button {
            output.onTapAddNewAddress()
        } label: {}
            .buttonStyle(CustomButton())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
    }
}

// MARK: - Helper

private extension PickAddressScreenView {

    struct CustomButton: ButtonStyle {

        func makeBody(configuration: Configuration) -> some View {
            HStack(spacing: 16) {
                DLIcon.plus.image

                Text("Добавить")
                    .style(size: 17, weight: .regular, color: Constants.textColor)
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(
                configuration.isPressed
                    ? DLColor<BackgroundPalette>.lightGray.color
                    : .clear,
                in: .capsule
            )
        }
    }
}

// MARK: - Constants

private extension PickAddressScreenView {

    enum Constants {
        static let textColor = DLColor<TextPalette>.primary.color
        static let navigationTitle = String(localized: "Адреса доставки")
    }
}
