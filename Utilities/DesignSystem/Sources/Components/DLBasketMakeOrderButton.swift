//
// DLBasketMakeOrderButton.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 27.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

extension DLBasketMakeOrderButton {

    public struct Configuration {
        let state: ButtonState
        let title: String
        let subtitle: String
        let isDisable: Bool

        public init(
            state: ButtonState,
            title: String,
            subtitle: String,
            isDisable: Bool
        ) {
            self.state = state
            self.title = title
            self.subtitle = subtitle
            self.isDisable = isDisable
        }
    }
}

public struct DLBasketMakeOrderButton: View {

    private let configuration: Configuration
    private let didTapButton: DLVoidBlock?

    public init(configuration: Configuration, didTapButton: DLVoidBlock? = nil) {
        self.configuration = configuration
        self.didTapButton = didTapButton
    }

    public var body: some View {
        DLButton(
            configuration: .init(
                state: configuration.state,
                hasDisabled: configuration.isDisable,
                titleView: {
                    Text(configuration.title)
                        .style(size: 16, weight: .semibold, color: Constants.textColor)
                },
                subtileView: {
                    Text(configuration.subtitle)
                        .style(size: 13, weight: .semibold, color: Constants.textColor)
                }
            ),
            action: didTapButton
        )
        .disabled(configuration.isDisable)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 30) {
        DLBasketMakeOrderButton(
            configuration: .init(
                state: .default,
                title: "title",
                subtitle: "subtitle",
                isDisable: false
            )
        )

        Divider()

        DLBasketMakeOrderButton(
            configuration: .init(
                state: .default,
                title: "title",
                subtitle: "subtitle",
                isDisable: true
            )
        )
    }
    .padding(.horizontal, 12)
}

// MARK: - Constants

private extension DLBasketMakeOrderButton {

    enum Constants {
        static let textColor = DLColor<TextPalette>.white.color
        static let primaryTextColor = DLColor<TextPalette>.primary.color
        static let bgButtonColor = DLColor<BackgroundPalette>.blue.color
        static let bgDisableButtonColor = DLColor<BackgroundPalette>.lightGray2.color
        static let iconColor = DLColor<IconPalette>.primary.color
    }
}
