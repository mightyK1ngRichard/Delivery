//
//  Created by Dmitriy Permyakov on 01.09.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import SharedUserStories

final class CatalogProductsScreenViewModel {

    private var state: CatalogProductsState
    private let networkClient: AnyCatalogProductsScreenNetworkClient
    private let factory: AnyCatalogProductsScreenFactory
    private weak var output: CatalogProductsOutput?

    private let logger = DLLogger("Catalog Products Screen")

    init(
        state: CatalogProductsState,
        networkClient: AnyCatalogProductsScreenNetworkClient,
        factory: AnyCatalogProductsScreenFactory,
        output: CatalogProductsOutput
    ) {
        self.state = state
        self.networkClient = networkClient
        self.factory = factory
        self.output = output
    }
}

// MARK: - CatalogProductsViewOutput

extension CatalogProductsScreenViewModel: CatalogProductsViewOutput {

    func onFirstAppear() {
        logger.logEvent()

        state.screenState = .loading
        Task {
            do {
                let categoryID = state.category.id
                let products = try await networkClient.fetchCategoryProducts(categoryID: categoryID)
                let mappedProducts = products.compactMap(factory.convertToProduct)
                state.items = mappedProducts.map { .init(sectionID: categoryID, product: $0) }
            } catch {
                logger.error(error)
                output?.catalogProductsShowAlertError(message: error.localizedDescription)
            }

            state.screenState = .content
        }
    }

    func onSelectTag(tag: CategoryModel) {
        logger.logEvent()
        
        if let index = state.selectedTags.firstIndex(where: { $0 == tag }) {
            state.selectedTags.remove(at: index)
            let filteredItems = state.items.filter { $0.sectionID != tag.id }
            state.items = filteredItems
        } else {
            state.selectedTags.insert(tag)
            state.lastSelectedTag = tag

            state.screenState = .loading
            Task {
                do {
                    let categoryID = tag.id
                    let products = try await networkClient.fetchCategoryProducts(categoryID: categoryID)
                    let mappedProducts = products.compactMap(factory.convertToProduct)
                    state.items.append(contentsOf: mappedProducts.map {
                        .init(sectionID: categoryID, product: $0)
                    })
                } catch {
                    logger.error(error)
                    output?.catalogProductsShowAlertError(message: error.localizedDescription)
                }

                state.screenState = .content
            }
        }
    }

    func onTapSortButton() {
        logger.logEvent()
    }

    func onTapSliderButton() {
        logger.logEvent()
    }

    func onTapProductLike(productID: Int, isLike: Bool) {
        logger.logEvent()
    }

    func onTapProductPlus(productID: Int, counter: Int) {
        logger.logEvent()
        updateCartCount(productID: productID, increment: 1)
    }

    func onTapProductMinus(productID: Int, counter: Int) {
        logger.logEvent()
        updateCartCount(productID: productID, increment: -1)
    }

    func onTapProductBasket(productID: Int, counter: Int) {
        logger.logEvent()
        guard let index = state.items.firstIndex(where: { $0.product.id == productID }) else {
            return
        }

        state.items[index].product.count = 1
        Task {
            try await networkClient.addProductInBasket(
                productID: productID,
                count: state.items[index].product.count
            )
        }
    }

    func onTapProductCard(product: ProductModel) {
        logger.logEvent()
        output?.catalogProductsOpenProductDetails(product: product)
    }
}

// MARK: - Helpers

extension CatalogProductsScreenViewModel {

    @MainActor
    func updateCartCount(productID: Int, increment: Int) {
        guard let index = state.items.firstIndex(where: { $0.product.id == productID }) else {
            return
        }

        state.items[index].product.count += increment
        Task {
            try await networkClient.updateProductCountInBasket(
                productID: productID,
                count: state.items[index].product.count
            )
        }
    }
}
