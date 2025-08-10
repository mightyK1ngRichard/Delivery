//
//  Created by Dmitriy Permyakov on 01.09.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import DesignSystem
import SwiftUI
import DLCore
import SharedUserStories

extension CatalogProductsView {

    var mainContainer: some View {
        VStack(spacing: 0) {
            topHeaderView
            ScrollView {
                VStack {
                    tagsView
                    productsContainer
                }
            }
        }
        .navigationTitle(state.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension CatalogProductsView {

    var tagsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { reader in
                HStack(spacing: .SPx2) {
                    ForEach(state.tags) { tag in
                        tagCell(for: tag)
                    }
                }
                .padding(.top, .SPx2)
                .padding(.bottom, 14)
                .padding(.horizontal)
                .onAppear {
                    guard let id = state.lastSelectedTag?.id else { return }
                    reader.scrollTo(id, anchor: .center)
                }
                .onChange(of: state.lastSelectedTag) { tag in
                    guard let id = tag?.id else { return }
                    withAnimation {
                        reader.scrollTo(id, anchor: .center)
                    }
                }
            }
        }
    }

    func tagCell(for tag: CategoryModel) -> some View {
        Text(tag.title)
            .style(size: 15, weight: .semibold, color: Constants.textPrimary)
            .id(tag.id)
            .padding(.horizontal, .SPx3)
            .padding(.vertical, .SPx2)
            .background(Constants.bgGray, in: .rect(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .fill(state.getTagCellBorderColor(for: tag))
                    .padding(.vertical, 2)
            }
            .onTapGesture {
                output.onSelectTag(tag: tag)
            }
    }

    @ViewBuilder
    var productsContainer: some View {
        switch state.screenState {
        case .content:
            if state.products.isEmpty {
                emptyProductView
            } else {
                productCards
            }
        case .loading, .error:
            loadingView
        }
    }

    var loadingView: some View {
        VStack(spacing: .SPx2) {
            ForEach(0...10, id: \.self) { _ in
                HStack {
                    Group {
                        ShimmeringView()
                        ShimmeringView()
                    }
                    .clipShape(.rect(cornerRadius: 20))
                    .frame(height: 250)
                }
            }
        }
        .padding(.horizontal)
    }

    var emptyProductView: some View {
        DontResultView(
            configuration: .init(
                resourceName: "cryingEmoji",
                title: Constants.emptyTitle,
                subtitle: Constants.emptySubtitle
            )
        )
    }

    var productCards: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(), count: 2),
            spacing: .SPx2
        ) {
            ForEach(state.products) { product in
                productView(for: product)
            }
        }
        .padding(.horizontal)
    }

    var topHeaderView: some View {
        HStack {
            DLSearchField(text: $state.searchText)
            Button(action: output.onTapSortButton, label: {
                DLIcon.sort.image
                    .frame(width: 24, height: 24)
            })
            Button(action: output.onTapSliderButton, label: {
                DLIcon.slider.image
                    .frame(width: 24, height: 24)
            })
        }
        .padding(.vertical, 13)
        .padding(.horizontal)
        .background(Constants.bgWhite)
    }

    @ViewBuilder
    func productView(for product: ProductModel) -> some View {
        DProductCard(
            product: state.factory.convertToDProductCard(from: product),
            handler: .init(
                didTapLike: { isLike in
                    output.onTapProductLike(productID: product.id, isLike: isLike)
                },
                didTapPlus: { counter in
                    output.onTapProductPlus(productID: product.id, counter: counter)
                },
                didTapMinus: { counter in
                    output.onTapProductMinus(productID: product.id, counter: counter)
                },
                didTapBasket: { counter in
                    output.onTapProductBasket(productID: product.id, counter: counter)
                }
            )
        )
        .onTapGesture {
            output.onTapProductCard(product: product)
        }
    }
}

// MARK: - Constants

private extension CatalogProductsView {

    enum Constants {
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let bgGray = DLColor<BackgroundPalette>.gray100.color
        static let bgWhite = DLColor<BackgroundPalette>.white.color
        static let emptyTitle = "Пусто"
        static let emptySubtitle = "Продуктов данных категорий не обнаруженно"
    }
}
