//
// DLProductHCard.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 09.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

struct DLProductHCard: View {

    let configuration: Configuration
    var handlerConfiguration: HandlerConfiguration

    @State private var counter: Int
    @State private var isLiked: Bool

    init(
        configuration: Configuration,
        handlerConfiguration: HandlerConfiguration = .init()
    ) {
        self.configuration = configuration
        self.handlerConfiguration = handlerConfiguration
        self._counter = State(initialValue: configuration.startCount)
        self._isLiked = State(initialValue: configuration.isLiked)
    }

    var body: some View {
        HStack(spacing: 0) {
            DLImageView(
                configuration: .init(
                    imageKind: configuration.imageKind,
                    contentMode: .fit
                )
            )
            .background(.ultraThinMaterial)
            .frame(width: 130)

            VStack(alignment: .leading) {
                ProductContent

                Spacer()

                ButtonsView
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 12)
            }
        }
        .overlay(alignment: .topTrailing) {
            HStack(spacing: .SPx1) {
                DLIcon.money.image
                Text(configuration.cornerPrice)
                    .style(
                        size: 13,
                        weight: .semibold,
                        color: DLColor<TextPalette>.primary.color
                    )
            }
            .padding(.vertical, 6)
            .padding(.horizontal, .SPx2)
            .background(DLColor<BackgroundPalette>.yellow.color)
            .cornerRadius(.CRx3, corners: [.bottomLeft])
        }
        .clipShape(.rect(cornerRadius: 20))
        .overlay(alignment: .topLeading) {
            DLLikeView(
                isLiked: configuration.isLiked,
                didTapLike: handlerConfiguration.didTapLike
            )
            .padding([.leading, .top], 8)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 1)
                .fill(DLColor<SeparatorPalette>.gray.color)
        }
    }
}

// MARK: - Action

private extension DLProductHCard {

    func didTapMinus() {
        guard counter > 0 else { return }
        counter = max(0, counter - configuration.magnifier)
        handlerConfiguration.didTapMinus?(counter)
    }

    func didTapPlus() {
        counter += configuration.magnifier
        handlerConfiguration.didTapPlus?(counter)
    }

    func didTapDelete() {
        handlerConfiguration.didTapDelete?(counter)
    }
}

// MARK: - Configuration

extension DLProductHCard {

    struct Configuration {
        var title: String
        var price: String
        var unitPrice: String
        var cornerPrice: String
        var startCount: Int
        var isLiked: Bool
        var imageKind: ImageKind
        /// Увелечитель суммы при нажатии плюс или минус
        var magnifier: Int
        var buttonKind: ButtonKind = .delete
    }
}

extension DLProductHCard.Configuration {

    enum ButtonKind {
        case delete
        case info
    }
}

// MARK: - HandlerConfiguration

extension DLProductHCard {

    struct HandlerConfiguration {
        var didTapPlus: DLIntBlock?
        var didTapMinus: DLIntBlock?
        var didTapLike: DLBoolBlock?
        var didTapDelete: DLIntBlock?
        var didTapInfo: DLVoidBlock?
    }
}

// MARK: - UI Subviews

private extension DLProductHCard {

    var ProductContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(configuration.price)
                .font(.headline)
                .foregroundStyle(DLColor<TextPalette>.primary.color)

            Text(configuration.unitPrice)
                .style(size: 14, weight: .medium, color: DLColor<TextPalette>.gray800.color)

            Text(configuration.title)
                .style(size: 14, weight: .semibold, color: DLColor<TextPalette>.primary.color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.top, 12)
    }

    var ButtonsView: some View {
        HStack(spacing: .SPx3) {
            LeftButton
            StepperView
        }
    }

    @ViewBuilder
    var LeftButton: some View {
        switch configuration.buttonKind {
        case .delete:
            Button(action: didTapDelete, label: {
                DLIcon.trash.image
                    .renderingMode(.template)
                    .foregroundStyle(DLColor<IconPalette>.primary.color)
                    .frame(width: 32, height: 32)
                    .background(DLColor<BackgroundPalette>.lightGray.color, in: .circle)
            })
        case .info:
            Button {
                handlerConfiguration.didTapInfo?()
            } label: {
                DLIcon.info.image
                    .renderingMode(.template)
                    .foregroundStyle(DLColor<IconPalette>.primary.color)
                    .frame(width: 32, height: 32)
                    .background(DLColor<BackgroundPalette>.lightGray.color, in: .circle)
            }
        }
    }

    var StepperView: some View {
        DLStepper(
            configuration: .init(
                startCounter: configuration.startCount,
                magnifier: configuration.magnifier
            ),
            handlerConfiguration: .init(
                didTapPlus: handlerConfiguration.didTapPlus,
                didTapMinus: handlerConfiguration.didTapMinus
            )
        )
    }
}
