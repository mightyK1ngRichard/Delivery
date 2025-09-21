//
//  Created by Dmitriy Permyakov on 09.07.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

public struct DLProductHCard: View {

    @State
    private var counter: Int

    @State
    private var isLiked: Bool

    private let configuration: Configuration
    private let handlerConfiguration: HandlerConfiguration

    public init(
        configuration: Configuration,
        handlerConfiguration: HandlerConfiguration = .init()
    ) {
        self.configuration = configuration
        self.handlerConfiguration = handlerConfiguration
        self._counter = State(initialValue: configuration.startCount)
        self._isLiked = State(initialValue: configuration.isLiked)
    }

    public var body: some View {
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
        handlerConfiguration.didTapMinus?()
    }

    func didTapPlus() {
        counter += configuration.magnifier
        handlerConfiguration.didTapPlus?()
    }

    func didTapDelete() {
        handlerConfiguration.didTapDelete?()
    }
}

// MARK: - Configuration

extension DLProductHCard {

    public struct Configuration {
        let title: String
        let price: String
        let unitPrice: String
        let cornerPrice: String
        let startCount: Int
        let isLiked: Bool
        let imageKind: ImageKind
        /// Увелечитель суммы при нажатии плюс или минус
        let magnifier: Int
        let buttonKind: ButtonKind

        public init(
            title: String,
            price: String,
            unitPrice: String,
            cornerPrice: String,
            startCount: Int,
            isLiked: Bool,
            imageKind: ImageKind,
            magnifier: Int,
            buttonKind: ButtonKind = .delete
        ) {
            self.title = title
            self.price = price
            self.unitPrice = unitPrice
            self.cornerPrice = cornerPrice
            self.startCount = startCount
            self.isLiked = isLiked
            self.imageKind = imageKind
            self.magnifier = magnifier
            self.buttonKind = buttonKind
        }
    }
}

// MARK: - ButtonKind

extension DLProductHCard.Configuration {

    public enum ButtonKind {
        case delete
        case info
    }
}

// MARK: - HandlerConfiguration

extension DLProductHCard {

    public struct HandlerConfiguration {
        let didTapPlus: DLVoidBlock?
        let didTapMinus: DLVoidBlock?
        let didTapLike: DLBoolBlock?
        let didTapDelete: DLVoidBlock?
        let didTapInfo: DLVoidBlock?

        public init(
            didTapPlus: DLVoidBlock? = nil,
            didTapMinus: DLVoidBlock? = nil,
            didTapLike: DLBoolBlock? = nil,
            didTapDelete: DLVoidBlock? = nil,
            didTapInfo: DLVoidBlock? = nil
        ) {
            self.didTapPlus = didTapPlus
            self.didTapMinus = didTapMinus
            self.didTapLike = didTapLike
            self.didTapDelete = didTapDelete
            self.didTapInfo = didTapInfo
        }
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
                counter: configuration.startCount,
                magnifier: configuration.magnifier
            ),
            handlerConfiguration: .init(
                didTapPlus: handlerConfiguration.didTapPlus,
                didTapMinus: handlerConfiguration.didTapMinus
            )
        )
    }
}
