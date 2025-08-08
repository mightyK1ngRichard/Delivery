//
// DProductCard.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 16.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Kingfisher
import SwiftUI
import DLCore

public struct DProductCard: View {

    public struct HandlerConfiguration {
        var didTapLike: DLBoolBlock?
        var didTapPlus: DLIntBlock?
        var didTapMinus: DLIntBlock?
        var didTapBasket: DLIntBlock?

        public init(
            didTapLike: DLBoolBlock? = nil,
            didTapPlus: DLIntBlock? = nil,
            didTapMinus: DLIntBlock? = nil,
            didTapBasket: DLIntBlock? = nil
        ) {
            self.didTapLike = didTapLike
            self.didTapPlus = didTapPlus
            self.didTapMinus = didTapMinus
            self.didTapBasket = didTapBasket
        }
    }

    let product: DProductCardModel
    let handler: HandlerConfiguration

    @State
    private var showStepper: Bool

    public init(
        product: DProductCardModel,
        handler: HandlerConfiguration = .init(),
        showStepper: Bool = false
    ) {
        self.product = product
        self.handler = handler
        self._showStepper = State(initialValue: showStepper)
    }

    public var body: some View {
        MainContainer
            .padding(.vertical, 1)
            .contentShape(.rect)
    }
}

private extension DProductCard {

    var MainContainer: some View {
        ProductCardContent
            .background(
                RoundedRectangle(cornerRadius: .CRx5)
                    .fill(.background)
            )
            .overlay(
                RoundedRectangle(cornerRadius: .CRx5)
                    .stroke(Constants.borderColor, lineWidth: 1)
            )
    }

    var ProductCardContent: some View {
        VStack(spacing: 0) {
            ImageContainer
                .padding(.bottom, .SPx3)
            ProductInfoBlock
                .padding(.bottom, .SPx2)
            ResultButtonView
                .padding(.bottom, .SPx3)
        }
    }

    var ImageContainer: some View {
        ProductImage
            .clipShape(CustomShape())
            .overlay(alignment: .topLeading) {
                TagsStack
                    .padding([.top, .leading], .SPx3)
            }
            .overlay(alignment: .topTrailing) {
                LikeButton
                    .padding([.top, .trailing], .SPx3)
            }
    }

    var ProductImage: some View {
        DLImageView(
            configuration: .init(
                imageKind: .url(product.imageURL),
                contentMode: .fit
            )
        )
        .frame(height: 180)
        .background(.ultraThinMaterial)
    }

    var TagsStack: some View {
        VStack(alignment: .leading, spacing: .SPx1) {
            ForEach(
                product.tags.sorted(by: { $0.rawValue < $1.rawValue }),
                id: \.self
            ) { productTag in
                Text(productTag.rawValue)
                    .font(.system(size: 11))
                    .padding(.horizontal, .SPx1)
                    .padding(.vertical, .SPx0_5)
                    .background(productTag.backgroundColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
            }
        }
    }

    var LikeButton: some View {
        DLLikeView(
            isLiked: product.isLike,
            didTapLike: handler.didTapLike
        )
    }

    var ProductInfoBlock: some View {
        VStack(alignment: .leading, spacing: .SPx1) {
            ProductPrice
            ProductTitle
            Spacer(minLength: 0)
            ProductDescription
        }
        .padding(.horizontal, .SPx2)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var ProductPrice: some View {
        Text(product.price)
            .font(.headline)
            .lineLimit(1)
    }

    var ProductTitle: some View {
        Text(product.title)
            .font(.system(size: 13))
            .bold()
            .lineLimit(2)
    }

    var ProductDescription: some View {
        Text(product.description)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .lineLimit(1)
    }

    @ViewBuilder
    var ResultButtonView: some View {
        if showStepper {
            StepperView
        } else {
            BuyButton
        }
    }

    var StepperView: some View {
        DLStepper(
            configuration: .init(
                startCounter: product.startCounter,
                magnifier: product.magnifier
            ),
            handlerConfiguration: .init(
                didTapPlus: handler.didTapPlus,
                didTapMinus: handler.didTapMinus
            )
        )
    }

    var BuyButton: some View {
        Button {
            showStepper = true
            handler.didTapBasket?(product.startCounter)
        } label: {
            HStack {
                Image(systemName: "plus")
                Text("В корзину")
            }
            .padding(.SPx3)
            .frame(maxWidth: .infinity)
        }
        .background(Constants.buyButtonBackgroundColor)
        .foregroundStyle(.black)
        .cornerRadius(10)
        .padding(.horizontal, .SPx3)
    }
}

// MARK: - Preview

#Preview {
    DProductCard(product: .init(
        id: 1,
        imageURL: URL(string: "https://avatars.mds.yandex.net/i?id=f2f6c7de9b79887ad4f3188da5d2ca0e_l-5254684-images-thumbs&n=13"),
        title: "Тут длинное название на две строки",
        price: "99",
        description: "Описание",
        startCounter: 0,
        magnifier: 1,
        tags: [.promotion, .hit, .exclusive]
    ))
    .frame(width: 167, height: 338)
}

// MARK: - Constants

extension DProductCard {

    enum Constants {
        static let buyButtonBackgroundColor = Color(uiColor: UIColor(rgb: 0xF5F5F5))
        static let borderColor = Color(uiColor: UIColor(rgb: 0xEDEFF1))
    }
}
