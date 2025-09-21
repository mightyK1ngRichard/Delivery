//
//  Created by Dmitriy Permyakov on 03.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import DLCore
import Combine
import CartServiceInterface
import Foundation

final class AllProductsScreenViewModel {

    private let state: AllProductsScreenViewState
    private let cartService: AnyCartService
    private let networkClient: AnyAllProductsNetworkClient
    private weak var output: AllProductsScreenOutput?

    private let logger = DLLogger("All Products Screen View Model")

    private var store: Set<AnyCancellable> = []

    init(
        state: AllProductsScreenViewState,
        cartService: AnyCartService,
        networkClient: AnyAllProductsNetworkClient,
        output: AllProductsScreenOutput
    ) {
        self.state = state
        self.cartService = cartService
        self.networkClient = networkClient
        self.output = output

        cartService.basketProductsPublisher
            .receive(on: RunLoop.main)
            .sink { products in
                state.selectedProducts = Set(products.map(\.id))
                products.forEach { product in
                    if let productIndex = state.products.firstIndex(where: { $0.id == product.id }) {
                        state.products[productIndex].count = product.count
                        return
                    }
                }
            }
            .store(in: &store)
    }
}

// MARK: - AllProductsScreenViewOutput

extension AllProductsScreenViewModel: AllProductsScreenViewOutput {

    func onFirstAppear() {
        logger.logEvent()
    }

    func onTapProductCard(for product: ProductModel) {
        logger.logEvent()
        output?.allProductsScreenDidTapOpenProuctDetails(with: product)
    }

    func onTapProductLike(productID: Int, isLike: Bool) {
        logger.logEvent()
    }

    func onTapProductPlus(productID: Int) {
        logger.logEvent()
        changeProductCount(productID: productID, increment: 1)
    }

    func onTapProductMinus(productID: Int) {
        logger.logEvent()
        changeProductCount(productID: productID, increment: -1)
    }

    func onTapProductBasket(productID: Int) {
        logger.logEvent()

        guard let index = state.products.firstIndex(where: { $0.id == productID }) else {
            return
        }

        state.products[index].count = 1
        Task {
            try await networkClient.addProductInBasket(productID: productID, count: 1)
        }
    }
}

// MARK: - Helpers

extension AllProductsScreenViewModel {

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
