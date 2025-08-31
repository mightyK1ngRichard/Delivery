//
//  Created by Dmitriy Permyakov on 03.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import DLCore

final class AllProductsScreenViewModel {

    private let state: AllProductsScreenViewState
    private let networkClient: AnyAllProductsNetworkClient
    private weak var output: AllProductsScreenOutput?

    private let logger = DLLogger("All Products Screen View Model")

    init(
        state: AllProductsScreenViewState,
        networkClient: AnyAllProductsNetworkClient,
        output: AllProductsScreenOutput
    ) {
        self.state = state
        self.networkClient = networkClient
        self.output = output
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

    func onTapProductPlus(productID: Int, counter: Int) {
        logger.logEvent()
        changeProductCount(productID: productID, increment: 1)
    }

    func onTapProductMinus(productID: Int, counter: Int) {
        logger.logEvent()
        changeProductCount(productID: productID, increment: -1)
    }

    func onTapProductBasket(productID: Int, counter: Int) {
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
