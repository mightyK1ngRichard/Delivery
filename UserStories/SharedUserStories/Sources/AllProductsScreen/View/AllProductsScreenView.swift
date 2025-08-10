//
//  Created by Dmitriy Permyakov on 03.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import SwiftUI
import DesignSystem

struct AllProductsScreenView: View {

    @ObservedObject
    var state: AllProductsScreenViewState
    let output: AllProductsScreenViewOutput

    var body: some View {
        mainContainer
            .onFirstAppear(perform: output.onFirstAppear)
    }
}

// MARK: - Private

private extension AllProductsScreenView {

    var mainContainer: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: GridItem(), count: 2),
                spacing: .SPx2,
                content: productsContainer
            )
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
        .navigationTitle(state.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    func productsContainer() -> some View {
        ForEach(state.products) { product in
            dsProductCard(
                model: state.factory.convertToDProductCard(from: product)
            )
            .onTapGesture {
                output.onTapProductCard(for: product)
            }
        }
    }

    func dsProductCard(model: DProductCardModel) -> some View {
        DProductCard(
            product: model,
            handler: .init(
                didTapLike: { isLike in
                    output.onTapProductLike(productID: model.id, isLike: isLike)
                },
                didTapPlus: { counter in
                    output.onTapProductPlus(productID: model.id, counter: counter)
                },
                didTapMinus: { counter in
                    output.onTapProductMinus(productID: model.id, counter: counter)
                },
                didTapBasket: { counter in
                    output.onTapProductBasket(productID: model.id, counter: counter)
                }
            )
        )
    }
}

// MARK: - Constants

private extension AllProductsScreenView {

    enum Constants {

        static let textPrimary = DLColor<TextPalette>.primary.color
    }
}
