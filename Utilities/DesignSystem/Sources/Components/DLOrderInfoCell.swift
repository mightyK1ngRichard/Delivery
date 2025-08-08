//
// DLOrderInfoCell.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 06.09.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

public struct DLOrderInfoCell: View {

    let configuration: Configuration
    var handlerConfigurations = HandlerConfigurations()

    public init(
        configuration: Configuration,
        handlerConfigurations: DLOrderInfoCell.HandlerConfigurations = HandlerConfigurations()
    ) {
        self.configuration = configuration
        self.handlerConfigurations = handlerConfigurations
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: .SPx6) {
            dateContainer
            priceContainer
            cashbackContainer
            statusContainer
            paymentContainer
            buttonsContainer
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: .CRx4)
                .stroke(lineWidth: 1)
                .fill(Constants.strokeColor)
        }
        .padding(1)
    }
}

// MARK: - Configuration

extension DLOrderInfoCell {

    public struct Configuration {
        let date: String
        let price: String
        let cashback: String
        let creditedInfo: String
        let status: Status
        let payment: String

        public init(
            date: String,
            price: String,
            cashback: String,
            creditedInfo: String,
            status: Status,
            payment: String
        ) {
            self.date = date
            self.price = price
            self.cashback = cashback
            self.creditedInfo = creditedInfo
            self.status = status
            self.payment = payment
        }
    }
}

extension DLOrderInfoCell.Configuration {

    public enum Status: String {
        case accepted = "принят"
        case cancelled = "отменён"
        case error = "ошибка"
    }
}

extension DLOrderInfoCell.Configuration.Status {

    var color: Color {
        switch self {
        case .accepted: .green
        case .cancelled, .error: DLColor<TextPalette>.red.color
        }
    }
}

extension DLOrderInfoCell {

    public struct HandlerConfigurations {
        var didTapInfo: DLVoidBlock?
        var didTapReload: DLVoidBlock?

        public init(
            didTapInfo: DLVoidBlock? = nil,
            didTapReload: DLVoidBlock? = nil
        ) {
            self.didTapInfo = didTapInfo
            self.didTapReload = didTapReload
        }
    }
}

// MARK: - UI Subviews

private extension DLOrderInfoCell {

    func textView(text: String, isTitle: Bool) -> some View {
        Text(text)
            .style(
                size: isTitle ? 13 : 17,
                weight: isTitle ? .semibold : .regular,
                color: Constants.textPrimary
            )
    }

    var dateContainer: some View {
        VStack(alignment: .leading, spacing: Constants.titleSubtitlePadding) {
            textView(text: "Дата", isTitle: true)
            textView(text: configuration.date, isTitle: false)
        }
    }

    var priceContainer: some View {
        VStack(alignment: .leading, spacing: Constants.titleSubtitlePadding) {
            textView(text: "Сумма", isTitle: true)
            textView(text: configuration.price, isTitle: false)
        }
    }

    var cashbackContainer: some View {
        VStack(alignment: .leading, spacing: Constants.titleSubtitlePadding) {
            textView(text: "Кешбек", isTitle: true)
            HStack {
                textView(text: configuration.cashback, isTitle: false)
                Spacer()
                Text(configuration.creditedInfo)
                    .style(size: 17, weight: .regular, color: Constants.textSecondary)
            }
        }
    }

    var statusContainer: some View {
        VStack(alignment: .leading, spacing: Constants.titleSubtitlePadding) {
            textView(text: "Статус", isTitle: true)
            Text(configuration.status.rawValue.capitalized)
                .style(size: 17, weight: .regular, color: configuration.status.color)
        }
    }

    var paymentContainer: some View {
        VStack(alignment: .leading, spacing: Constants.titleSubtitlePadding) {
            textView(text: "Оплата", isTitle: true)
            textView(text: configuration.payment, isTitle: false)
        }
    }

    var buttonsContainer: some View {
        HStack(spacing: .SPx2) {
            moreButton
            reloadButton
        }
    }

    var moreButton: some View {
        Button {
            handlerConfigurations.didTapInfo?()
        } label: {
            HStack {
                DLIcon.info.image
                    .renderingMode(.template)
                Text("Подробнее")
            }
        }
        .buttonStyle(CustomButtonStyle(kind: .stroke))
    }

    var reloadButton: some View {
        Button {
            handlerConfigurations.didTapReload?()
        } label: {
            HStack(spacing: .SPx2) {
                DLIcon.reload.image
                    .frame(width: 16, height: 16)
                Text("Повторить")
                    .style(size: 16, weight: .semibold, color: Constants.textWhite)
            }
        }
        .buttonStyle(CustomButtonStyle(kind: .fill))
    }
}

// MARK: - Preview

#Preview {
    DLOrderInfoCell(
        configuration: .init(
            date: "2023-06-13 20:15:37",
            price: "7 132.00 ₽",
            cashback: "67 ₽",
            creditedInfo: "Не начислен",
            status: .cancelled,
            payment: "Счет"
        )
    )
    .padding()
}

// MARK: - Constants

private extension DLOrderInfoCell {

    enum Constants {
        static let titleSubtitlePadding: CGFloat = .SPx2
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let textWhite = DLColor<TextPalette>.white.color
        static let textDarkBlue = DLColor<TextPalette>.darkBlue.color
        static let textSecondary = DLColor<TextPalette>.gray800.color
        static let textRed = DLColor<TextPalette>.red.color
        static let strokeColor = DLColor<SeparatorPalette>.gray.color
    }
}

// MARK: - CustomButtonStyle

private struct CustomButtonStyle: ButtonStyle {

    var kind: Kind
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal)
            .padding(.vertical, kind.vPadding)
            .frame(maxWidth: .infinity)
            .background(
                kind == .fill
                    ? configuration.isPressed ? Constants.bgLightBlue : Constants.strokeBlue
                    : configuration.isPressed ? Constants.bgDarkBlue : .clear,
                in: .rect(cornerRadius: 12)
            )
            .foregroundStyle(
                kind == .fill
                    ? Constants.textWhite
                    : configuration.isPressed ? Constants.textWhite : Constants.textDarkBlue
            )
            .overlay {
                if kind == .stroke {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 2)
                        .fill(Constants.strokeBlue)
                }
            }
    }
}

private extension CustomButtonStyle {

    enum Kind {
        case fill
        case stroke
    }
}

private extension CustomButtonStyle.Kind {

    var highlightedColor: Color {
        switch self {
        case .fill: .gray
        case .stroke: DLColor<BackgroundPalette>(
                hexLight: 0x181B67,
                hexDark: 0x181B67
            ).color
        }
    }

    var vPadding: CGFloat {
        switch self {
        case .fill: 18
        case .stroke: 17
        }
    }
}

private extension CustomButtonStyle {

    enum Constants {
        static let textWhite = DLColor<TextPalette>.white.color
        static let textDarkBlue = DLColor<TextPalette>.darkBlue.color
        static let bgDarkBlue = DLColor<BackgroundPalette>.blue.color
        static let strokeBlue = DLColor<SeparatorPalette>.blue.color
        static let bgLightBlue = DLColor<BackgroundPalette>(
            hexLight: 0x181B67,
            hexDark: 0x181B67
        ).color
    }
}
