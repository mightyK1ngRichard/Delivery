//
// DLProductsCarousel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 28.07.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore

struct DLProductsCarousel: View {
    var configuration: Configuration
    var handlerConfiguration = HandlerConfiguration()

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            titleContainer
            productsContainer
            Divider()
                .padding(.top, 15)
                .padding(.leading)
        }
    }
}

// MARK: - Configurations

extension DLProductsCarousel {

    struct Configuration {
        var title = ""
        var products: [BasketViewState.Product] = []
    }

    struct HandlerConfiguration {
        var didTapTitle: DLVoidBlock?
        var didTapProduct: DLGenericBlock<BasketViewState.Product>?
    }
}

// MARK: - UI Subviews

private extension DLProductsCarousel {

    var titleContainer: some View {
        HStack {
            Text(configuration.title)
                .style(size: 17, weight: .semibold, color: DLColor<TextPalette>.primary.color)
            Spacer()
            Image(.chivronRight)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 9)
                .foregroundStyle(DLColor<IconPalette>.secondary.color)
                .frame(width: 44, height: 44)
        }
        .padding(.horizontal)
        .onTapGesture {
            handlerConfiguration.didTapTitle?()
        }
    }

    var productsContainer: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .SPx2) {
                ForEach(configuration.products) { product in
                    productCardView(for: product).onTapGesture {
                        handlerConfiguration.didTapProduct?(product)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    func productCardView(for product: BasketViewState.Product) -> some View {
        DLImageView(
            configuration: .init(
                imageKind: .string(product.imageURL),
                contentMode: .fit
            )
        )
        .frame(width: 75, height: 100)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 20))
    }
}
