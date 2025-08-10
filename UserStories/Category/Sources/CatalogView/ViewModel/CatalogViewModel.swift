//
// CatalogViewModel.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 24.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import SharedUserStories

final class CatalogViewModel {

    private let state: CatalogViewState
    private let factory: AnyCatalogScreenFactory
    private let networkClient: AnyCatalogScreenNetworkClient
    private weak var output: CatalogOutput?
    private let logger = DLLogger("Catalog Screen View Model")

    init(
        state: CatalogViewState,
        factory: AnyCatalogScreenFactory,
        networkClient: AnyCatalogScreenNetworkClient,
        output: CatalogOutput
    ) {
        self.state = state
        self.factory = factory
        self.networkClient = networkClient
        self.output = output
    }
}

// MARK: - CatalogViewOutput

extension CatalogViewModel: CatalogViewOutput {

    func onFirstAppear() {
        logger.logEvent()
        fetchCategoriesAndHitsProducts()
    }

    func onTapReloadButton() {
        fetchCategoriesAndHitsProducts()
    }

    func onTapCategory(categoryID: Int) {
        guard let category = state.categories.first(where: { $0.id == categoryID }) else {
            logger.error("Категория с id=\(categoryID) не найдена")
            return
        }

        output?.openCategoryList(category: category)
    }

    func onTapLookAllProducts() {
        output?.openLookAllProducts(navigationTitle: "Популярные товары", products: state.products)
    }

    func onTapLikeProduct(id: Int, isLike: Bool) {
    }

    func onTapBasketProduct(id: Int, counter: Int) {
    }

    func onTapProductCard(product: ProductModel) {
        output?.openProductDetails(product: product)
    }
}

// MARK: - Helper

private extension CatalogViewModel {

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
}
