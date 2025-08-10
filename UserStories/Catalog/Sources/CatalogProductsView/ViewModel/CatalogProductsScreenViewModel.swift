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

    private let logger = DLLogger("Catalog Products Screen View Model")

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
        Task { @MainActor in
            do {
                let products = try await networkClient.fetchCategoryProducts(categoryID: state.category.id)
                let mappedProducts = products.compactMap(factory.convertToProduct)
                state.products = mappedProducts
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
        } else {
            state.selectedTags.insert(tag)
            state.lastSelectedTag = tag

            state.screenState = .loading
            Task { @MainActor in
                do {
                    let products = try await networkClient.fetchCategoryProducts(categoryID: tag.id)
                    let mappedProducts = products.compactMap(factory.convertToProduct)
                    // FIXME: Подумать про добавление только уникальных элементов
                    state.products.append(contentsOf: mappedProducts)
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
    }

    func onTapProductMinus(productID: Int, counter: Int) {
        logger.logEvent()
    }

    func onTapProductBasket(productID: Int, counter: Int) {
        logger.logEvent()
    }

    func onTapProductCard(product: ProductModel) {
        logger.logEvent()
        output?.catalogProductsOpenProductDetails(product: product)
    }
}
