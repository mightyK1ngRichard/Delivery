//
//  Created by Dmitriy Permyakov on 24.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DesignSystem

struct CatalogScreenView: View {

    @StateObject
    var state: CatalogScreenViewState
    let output: CatalogScreenViewOutput

    var body: some View {
        mainContainer.onFirstAppear {
            output.onFirstAppear()
        }
    }
}

// MARK: - UI Subviews

private extension CatalogScreenView {

    @ViewBuilder
    var mainContainer: some View {
        switch state.screenState {
        case .error:
            ErrorView(title: "Ошибка получения данных", handler: output.onTapReloadButton)
                .frame(maxHeight: .infinity, alignment: .top)
        case .loading, .content:
            content
        }
    }

    var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .SPx8) {
                sectionsContainer
                popcatContainer
            }
            .padding(.horizontal)
        }
        .searchable(
            text: $state.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Поиск"
        )
    }

    var sectionsContainer: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            Text("Категории")
                .style(size: 22, weight: .bold, color: Constants.textPrimary)

            DLCategoryBlock(
                configuration: .init(
                    isShimmering: state.isLoading,
                    cells: state.categories.map(state.factory.convertToDLCategoryBlockData)
                ),
                didSelectIcon: {
                    output.onTapCategory(categoryID: $0)
                }
            )
        }
        .padding(.top)
    }

    var popcatContainer: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            HStack {
                Text("Популярные товары")
                    .style(size: 22, weight: .bold, color: Constants.textPrimary)
                Spacer()
                Button {
                    output.onTapLookAllProducts()
                } label: {
                    Text("См. все")
                        .style(size: 17, weight: .regular, color: Constants.textBlue)
                }
            }

            if state.isLoading {
                shimmeringProducts
            } else {
                productsContainer
            }
        }
    }

    var productsContainer: some View {
        LazyVGrid(columns: [
            GridItem(),
            GridItem()
        ], spacing: .SPx2) {
            ForEach(state.filterProducts) { product in
                DProductCard(
                    product: state.factory.convertToDProductCard(from: product),
                    handler: .init(
                        didTapLike: { isLike in
                            output.onTapLikeProduct(id: product.id, isLike: isLike)
                        },
                        didTapPlus: {
                            output.onTapPlusProduct(productID: product.id)
                        },
                        didTapMinus: {
                            output.onTapMinusProduct(productID: product.id)
                        },
                        didTapBasket: {
                            output.onTapBasketProduct(id: product.id)
                        }
                    ),
                    showStepper: state.selectedProducts.contains(product.id)
                )
                .onTapGesture {
                    output.onTapProductCard(product: product)
                }
            }
        }
    }

    var shimmeringProducts: some View {
        HStack(spacing: .SPx2) {
            Group {
                ShimmeringView()
                ShimmeringView()
            }
            .clipShape(.rect(cornerRadius: 20))
            .frame(height: 338)
        }
    }
}

// MARK: - Constants

private extension CatalogScreenView {

    enum Constants {

        static let textPrimary = DLColor<TextPalette>.primary.color
        static let textBlue = DLColor<TextPalette>.darkBlue.color
    }
}

