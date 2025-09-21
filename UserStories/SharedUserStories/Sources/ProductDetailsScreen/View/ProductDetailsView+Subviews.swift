//
//  Created by Dmitriy Permyakov on 25.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DesignSystem

extension ProductDetailsView {

    var mainContainer: some View {
        ScrollView {
            VStack(alignment: .leading) {
                imageContainer
                bottomContainer
            }
            .padding(.horizontal)
        }
        .alert(state.alertModel, showAlert: $state.showAlert)
        .safeAreaInset(edge: .bottom) {
            bottomButtonKindView
                .padding()
        }
        .animation(.default, value: state.inBasket)
    }
}

private extension ProductDetailsView {

    @ViewBuilder
    var bottomButtonKindView: some View {
        if state.inBasket {
            HStack(spacing: 10) {
                inBasketButton
                stepperView
            }
        } else {
            addIntoBasketButton
        }
    }

    var stepperView: some View {
        HStack(spacing: .zero) {
            Button {
                output.onTapMinus()
            } label: {
                DLIcon.minus.image
                    .frame(width: 44, height: 65)
            }

            Text(String(state.productCount))
                .style(size: 16, weight: .semibold, color: .primary)

            Button {
                output.onTapPlus()
            } label: {
                DLIcon.plus.image
                    .frame(width: 44, height: 65)
            }
        }
        .background(DLColor<BackgroundPalette>.lightGray.color, in: .rect(cornerRadius: 12))
    }

    var inBasketButton: some View {
        VStack(spacing: .SPx0_5) {
            HStack(spacing: .SPx2) {
                DLIcon.checkMark.image
                Text("В корзине")
                    .style(size: 16, weight: .semibold, color: .white)
            }
            .frame(maxWidth: .infinity)

            Text("\(state.productCount) шт")
                .style(size: 13, weight: .semibold, color: .white)
        }
        .padding(.vertical, .SPx3)
        .padding(.horizontal, .SPx4)
        .background(Constants.greenColor.color, in: .rect(cornerRadius: 12))
    }

    @ViewBuilder
    var addIntoBasketButton: some View {
        if let text = state.makeBasketButtonTitle {
            DLButton(
                configuration: .init(
                    state: .default,
                    hasDisabled: false,
                    titleView: {
                        buttonHeader
                    },
                    subtileView: {
                        Text(text)
                            .style(size: 13, weight: .semibold, color: Constants.textWhite)
                    }
                ),
                action: output.onTapAddIntoBasketButton
            )
        } else {
            DLButton(
                configuration: .init(
                    state: .default,
                    hasDisabled: false,
                    titleView: {
                        buttonHeader
                    },
                    subtileView: { EmptyView() }
                ),
                action: output.onTapAddIntoBasketButton
            )
        }
    }

    var buttonHeader: some View {
        HStack(spacing: 8) {
            DLIcon.plus.image
                .renderingMode(.template)
                .frame(width: 16, height: 16)
                .foregroundStyle(DLColor<IconPalette>.white.color)
            Text("В корзину")
                .style(size: 16, weight: .semibold, color: Constants.textWhite)
        }
    }
}

// MARK: - Image Container

private extension ProductDetailsView {

    var imageContainer: some View {
        DLImageView(
            configuration: .init(
                imageKind: .url(state.product.imageURL),
                contentMode: .fit
            )
        )
        .frame(maxWidth: .infinity)
        .frame(height: 457)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 24))
        .overlay(alignment: .topLeading) {
            tagsStack
        }
        .overlay(alignment: .topTrailing) {
            buttonsContainer
        }
    }

    var tagsStack: some View {
        VStack(alignment: .leading, spacing: .SPx1) {
            ForEach(state.product.tags) { tag in
                Text(tag.title)
                    .style(size: 11, weight: .semibold, color: DLColor<TextPalette>.white.color)
                    .padding(.horizontal, .SPx1)
                    .padding(.vertical, .SPx0_5)
                    .background(tag.backgroundColor, in: .rect(cornerRadius: 7))
            }
        }
        .padding()
    }

    var buttonsContainer: some View {
        HStack {
            Button {
                output.onTapShare()
            } label: {
                DLIcon.share.image
                    .frame(width: 12, height: 12)
                    .padding(10)
            }
            .background(Constants.bgWhite, in: .circle)


            Button {
                output.onTapLike()
            } label: {
                DLIcon.heart.image
                    .frame(width: 12, height: 12)
                    .padding(10)
            }
            .background(Constants.bgWhite, in: .circle)
        }
        .padding(12)
    }
}

// MARK: - Bottom Container

extension ProductDetailsView {

    var bottomContainer: some View {
        VStack(alignment: .leading, spacing: .SPx1) {
            productTitleView
            detailContainer
        }
    }

    @ViewBuilder
    var productTitleView: some View {
        Text(state.product.title)
            .style(size: 22, weight: .bold, color: Constants.textPrimary)
    }

    var detailContainer: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            brandTitle
            priceContainer
            productAdditionalInfo
            DescriptionContainer
        }
    }

    @ViewBuilder
    var brandTitle: some View {
        if let brand = state.product.brand {
            HStack(spacing: .SPx1) {
                Text("Бренд:")
                    .style(size: 17, weight: .regular, color: Constants.textPrimary)

                Text(brand.title)
                    .style(size: 17, weight: .regular, color: Constants.textLink)
            }
        }
    }

    var priceContainer: some View {
        HStack(spacing: .SPx1) {
            Text(state.product.itemPrice.formattedPrice)
                .style(size: 22, weight: .bold, color: Constants.textPrimary)
            Text("/шт")
                .style(size: 17, weight: .regular, color: DLColor<TextPalette>.gray800.color)
            Spacer()
            WalletView(moneyCount: String(state.product.cashback), size: .size17)
        }
        .padding()
        .background(DLColor<BackgroundPalette>.gray100.color, in: .rect(cornerRadius: 16))
    }

    @ViewBuilder
    var productAdditionalInfo: some View {
        SubtitleInfo(
            iconKind: .box,
            title: "В упаковке:",
            text: state.product.packageCount.formattedCountTile
        )

        SubtitleInfo(
            iconKind: .time,
            title: "Срок годности:",
            text: state.product.formattedExpirationDate
        )
        .padding(.bottom, 12)
    }

    @ViewBuilder
    var DescriptionContainer: some View {
        Text(state.product.description)
            .style(size: 17, weight: .regular, color: Constants.textSecondary)
    }

    @ViewBuilder
    func SubtitleInfo(
        iconKind: DLIcon,
        title: String,
        text: String?
    ) -> some View {
        if let text {
            HStack(spacing: 6) {
                iconKind.image
                    .frame(width: 12, height: 12)
                Text(title)
                    .style(size: 17, weight: .regular, color: Constants.textSecondary)
                Text(text)
                    .style(size: 17, weight: .regular, color: Constants.textPrimary)
            }
        }
    }
}

// MARK: - Constants

private extension ProductDetailsView {

    enum Constants {

        static let textPrimary = DLColor<TextPalette>.primary.color
        static let textLink = DLColor<TextPalette>.blue.color
        static let textSecondary = DLColor<TextPalette>.gray800.color
        static let textWhite = DLColor<TextPalette>.white.color
        static let bgWhite = DLColor<BackgroundPalette>.white.color
        nonisolated(unsafe) static let greenColor = DLColor<BackgroundPalette>(hexLight: 0x00BC62, hexDark: 0x00BC62)
    }
}
