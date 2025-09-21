//
//  Created by Dmitriy Permyakov on 24.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import SharedUserStories

final class CatalogScreenViewModel {

    private let state: CatalogScreenViewState
    private let factory: AnyCatalogScreenFactory
    private let networkClient: AnyCatalogScreenNetworkClient
    private weak var output: CatalogScreenOutput?
    private let logger = DLLogger("Catalog Screen View Model")

    init(
        state: CatalogScreenViewState,
        factory: AnyCatalogScreenFactory,
        networkClient: AnyCatalogScreenNetworkClient,
        output: CatalogScreenOutput
    ) {
        self.state = state
        self.factory = factory
        self.networkClient = networkClient
        self.output = output
    }
}

// MARK: - CatalogViewOutput

extension CatalogScreenViewModel: CatalogScreenViewOutput {

    func onFirstAppear() {
        logger.logEvent()
        fetchCategoriesAndHitsProducts()
    }

    func onTapReloadButton() {
        logger.logEvent()
        fetchCategoriesAndHitsProducts()
    }

    func onTapCategory(categoryID: Int) {
        logger.logEvent()
        guard let category = state.categories.first(where: { $0.id == categoryID }) else {
            logger.error("Категория с id=\(categoryID) не найдена")
            return
        }

        output?.catalogScreenDidOpenCategoryList(category: category)
    }

    func onTapLookAllProducts() {
        logger.logEvent()
        output?.catalogScreenDidOpenLookAllProducts(navigationTitle: "Популярные товары", products: state.products)
    }

    func onTapLikeProduct(id: Int, isLike: Bool) {
        logger.logEvent()
    }

    func onTapPlusProduct(productID: Int) {
        logger.logEvent()
        changeProductCount(productID: productID, increment: 1)
    }

    func onTapMinusProduct(productID: Int) {
        logger.logEvent()
        changeProductCount(productID: productID, increment: -1)
    }

    func onTapBasketProduct(id productID: Int) {
        logger.logEvent()
        guard let index = state.products.firstIndex(where: { $0.id == productID }) else {
            logger.error("Товар с id=\(productID) не найден")
            return
        }

        state.products[index].count = 1
        Task {
            try await networkClient.addProductInBasket(productID: productID, count: 1)
        }
    }

    func onTapProductCard(product: ProductModel) {
        logger.logEvent()
        output?.catalogScreenDidOpenProductDetails(product: product)
    }
}

// MARK: - Helper

private extension CatalogScreenViewModel {

    @MainActor
    func fetchCategoriesAndHitsProducts() {
        state.screenState = .loading
        Task {
            do {
                let (categories, hitsProducts) = try await (
                    networkClient.fetchCategories(),
                    networkClient.fetchHitsProducts()
                )

                // Фильтруем самые популярные категории (9 шт.)
                let mappedCategories = categories
                    .filter { $0.parentID == 0 }
                    .compactMap(factory.convertToCategory)

                let hitProducts = hitsProducts.compactMap(factory.convertToProduct)

                state.categories = mappedCategories
                state.products = hitProducts
                state.screenState = .content
            } catch {
                logger.error(error)
                state.screenState = .error
            }
        }
    }

    @MainActor
    private func changeProductCount(productID: Int, increment: Int) {
        guard let index = state.products.firstIndex(where: { $0.id == productID }) else {
            logger.error("Товар с id=\(productID) не найден")
            return
        }

        state.products[index].count += increment
        Task {
            try await networkClient.updateProductCountInBasket(
                productID: productID,
                count: state.products[index].count
            )
        }
    }
}
