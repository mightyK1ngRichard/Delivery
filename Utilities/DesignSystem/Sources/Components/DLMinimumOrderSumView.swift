//
// DLMinimumOrderSumView.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 27.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

public struct DLMinimumOrderSumView: View {

    private let needPrice: String
    private let total: String
    private let isReady: Bool
    private let minimumSum: String
    private let didTapMakeOrderButton: DLVoidBlock

    @Binding
    var isOpened: Bool

    public init(
        needPrice: String,
        total: String,
        isReady: Bool,
        minimumSum: String,
        isOpened: Binding<Bool>,
        didTapMakeOrderButton: @escaping DLVoidBlock
    ) {
        self.needPrice = needPrice
        self.total = total
        self.isReady = isReady
        self.minimumSum = minimumSum
        self._isOpened = isOpened
        self.didTapMakeOrderButton = didTapMakeOrderButton
    }

    public var body: some View {
        MainView
    }
}

// MARK: - UI Subviews

private extension DLMinimumOrderSumView {

    @ViewBuilder
    var MainView: some View {
        if isReady {
            MakeOrderButton
        } else {
            ZStack(alignment: .bottom) {
                DLColor<BackgroundPalette>.overlay.color.opacity(isOpened ? 1 : 0)
                    .onTapGesture {
                        withAnimation(.bouncy) {
                            isOpened = false
                        }
                    }

                OrderDontReady
                    .padding(.top)
                    .background(DLColor<BackgroundPalette>.white.color)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
    }

    var OrderDontReady: some View {
        VStack(spacing: 16) {
            HStack(spacing: 0) {
                Spacer()
                Text("Еще \(needPrice) до минимального заказа")
                    .style(size: 11, weight: .semibold, color: DLColor<TextPalette>.primary.color)

                Spacer()

                if isOpened {
                    Button {
                        withAnimation(.snappy) {
                            isOpened = false
                        }
                    } label: {
                        DLIcon.xmark.image
                            .renderingMode(.template)
                            .foregroundStyle(Constants.iconColor)
                            .frame(width: 16, height: 16)
                    }
                } else {
                    DLIcon.chivronRight.image
                        .renderingMode(.template)
                        .foregroundStyle(Constants.iconColor)
                        .frame(width: 16, height: 16)
                }
            }
            .padding(.horizontal)
            .contentShape(.rect)
            .onTapGesture {
                withAnimation(.snappy) {
                    isOpened = true
                }
            }

            if isOpened {
                InfoMinimumSumView
            } else {
                MakeOrderButton
            }
        }
    }

    var MakeOrderButton: some View {
        DLButton(
            configuration: .init(
                hasDisabled: !isReady,
                titleView: {
                    Text("К оформлению")
                        .style(size: 16, weight: .semibold, color: Constants.textColor)
                },
                subtileView: {
                    Text("Итого: \(total)")
                        .style(size: 13, weight: .semibold, color: Constants.textColor)
                }
            ),
            action: didTapMakeOrderButton
        )
        .padding(.horizontal, 12)
        .padding(.bottom)
    }

    var InfoMinimumSumView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Минимальная сумма заказа \(minimumSum)")
                .style(size: 17, weight: .semibold, color: Constants.primaryTextColor)

            Text("Извините, но общая сумма вашего заказа должна быть больше минимальной суммы заказа ")
                .style(size: 14, weight: .regular, color: Constants.primaryTextColor)
        }
        .padding(.horizontal)
        .padding(.bottom, 48)
    }
}

// MARK: - Preview

#Preview {
    DLMinimumOrderSumView(
        needPrice: "4 210.4 ₽",
        total: "2 789.60 ₽",
        isReady: false,
        minimumSum: "7 000 ₽",
        isOpened: .constant(true)
    ) {}.ignoresSafeArea()
}

#Preview {
    VStack(spacing: 30) {
        DLMinimumOrderSumView(
            needPrice: "4 210.4 ₽",
            total: "2 789.60 ₽",
            isReady: true,
            minimumSum: "7 000 ₽",
            isOpened: .constant(false)
        ) {}

        Divider()

        DLMinimumOrderSumView(
            needPrice: "4 210.4 ₽",
            total: "2 789.60 ₽",
            isReady: false,
            minimumSum: "7 000 ₽",
            isOpened: .constant(false)
        ) {}
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.red)
}

// MARK: - Constants

private extension DLMinimumOrderSumView {

    enum Constants {

        static let textColor = DLColor<TextPalette>.white.color
        static let primaryTextColor = DLColor<TextPalette>.primary.color
        static let bgButtonColor = DLColor<BackgroundPalette>.blue.color
        static let bgDisableButtonColor = DLColor<BackgroundPalette>.lightGray2.color
        static let iconColor = DLColor<IconPalette>.primary.color
    }
}
