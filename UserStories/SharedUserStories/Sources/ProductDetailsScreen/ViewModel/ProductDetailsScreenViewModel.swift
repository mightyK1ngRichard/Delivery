//
//  Created by Dmitriy Permyakov on 25.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import CartServiceInterface
import DesignSystem

final class ProductDetailsScreenViewModel {

    private let state: ProductDetailsScreenViewState
    private let cartService: AnyCartService
    private let factory: AnyProductDetailsScreenFactory
    private weak var output: ProductDetailsScreenOutput?

    private let logger = DLLogger("Product Details Screen View Model")

    init(
        state: ProductDetailsScreenViewState,
        cartService: AnyCartService,
        factory: AnyProductDetailsScreenFactory,
        output: ProductDetailsScreenOutput
    ) {
        self.state = state
        self.cartService = cartService
        self.factory = factory
        self.output = output
    }
}

// MARK: - ProductDetailsViewOutput

extension ProductDetailsScreenViewModel: ProductDetailsViewOutput {

    func onFirstAppear() {
        logger.logEvent()
        state.makeBasketButtonTitle = factory.makeBasketButtonTitle(from: state.product)
    }

    func onTapAddIntoBasketButton() {
        logger.logEvent()
        state.productCount = state.product.magnifier
        state.basketButtonIsPressed = true

        Task {
            do {
                try await cartService.addProductInBasket(body: .init(productID: state.product.id, count: 1))
            } catch {
                logger.error(error)
            }
        }
    }

    func onTapLike() {
        logger.logEvent()
    }

    func onTapShare() {
        logger.logEvent()
    }

    func onTapPlus() {
        logger.logEvent()
        state.productCount += state.product.magnifier
        updateProductCount()
    }

    func onTapMinus() {
        logger.logEvent()
        state.productCount = max(0, state.productCount - state.product.magnifier)
        updateProductCount()
    }

    @MainActor
    private func updateProductCount() {
        Task {
            do {
                try await cartService.updateProductCountInBasket(
                    productID: state.product.id,
                    count: state.productCount / state.product.magnifier
                )

                state.basketButtonIsPressed = state.productCount != 0
            } catch {
                logger.error(error)
                state.alertModel = AlertModel(
                    title: "Ошибка изменения количества торара",
                    subtitle: "Не удалось изменить количество товара в корзине. Попробуйте еще раз позже."
                )
            }
        }
    }
}
