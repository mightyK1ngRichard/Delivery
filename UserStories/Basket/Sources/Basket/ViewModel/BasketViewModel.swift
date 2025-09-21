//
//  Created by Dmitriy Permyakov on 09.07.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import SwiftUI
import DLCore
import SharedContractsInterface
import SharedUserStories
import BasketInterface
import CartServiceInterface

final class BasketViewModel {

    private let state: BasketViewState
    private let networkClient: AnyBasketNetworkClient
    private let cartService: AnyCartService
    private let factory: AnyBasketScreenFactory
    private weak var output: BasketScreenOutput?

    private let logger = DLLogger("Basket Screen View Model")

    @MainActor
    private var totalPrice = 0.0
    private let minOrderPrice: MinOrderPrice

    init(
        state: BasketViewState,
        cartService: AnyCartService,
        networkClient: AnyBasketNetworkClient,
        factory: AnyBasketScreenFactory,
        output: BasketScreenOutput
    ) {
        self.state = state
        self.cartService = cartService
        self.networkClient = networkClient
        self.factory = factory
        self.output = output

        let minPrice = 7000.0
        minOrderPrice = .init(
            price: minPrice,
            formattedPrice: factory.makePriceFormatting(for: minPrice)
        )
    }
}

// MARK: - BasketViewOutput

extension BasketViewModel: BasketScreenViewOutput {

    func onFirstAppear() {
        logger.logEvent()
    }

    func onAppear() {
        logger.logEvent()

        updateNotificationsIfNeeded()
        fetchData()
    }

    func onTapReloadButton() {
        logger.logEvent()

        updateNotificationsIfNeeded()
        fetchData()
    }

    func onTapProduct(product: ProductModel) {
        logger.logEvent()
        output?.basketScreenDidOpenProductDetails(product: product)
    }

    func onTapOpenCatalog() {
        logger.logEvent()
        output?.basketScreenDidOpenCatalog()
    }

    func onTapMakeOrderButton() {
        logger.logEvent()

        let orderModel = OrderModel(
            totalAmount: .init(price: totalPrice, formatedPrice: state.amountInfo.resultSumTitle),
            products: state.products,
            includedBonuses: 0,
            paymentKind: .cash,
            deliveryDate: factory.deliveryDateTitle(),
            deliveryPrice: 0
        )
        output?.basketScreenDidOpenMakeOrderScreen(orderModel: orderModel)
    }

    func onTapPlus(product: ProductModel) {
        logger.logEvent()
        changeProductCount(product: product, increment: 1)
    }

    func onTapMinus(product: ProductModel) {
        logger.logEvent()
        changeProductCount(product: product, increment: -1)
    }

    func onTapLike(productID: Int, isSelected: Bool) {
        logger.logEvent()
    }

    func onTapDelete(productID: Int) {
        logger.logEvent()

        // Удаляем локально
        guard let index = state.products.firstIndex(where: { $0.id == productID }) else {
            state.showAlert(.init(
                title: "Ошибка удаления",
                subtitle: "Удаление продукта из корзины невозможно"
            ))
            return
        }

        // Обновляем UI
        let product = state.products[index]
        totalPrice -= product.fullPrice.price
        state.products.remove(at: index)
        updateResultSum()

        // Кидаем запрос на удаление
        Task(priority: .medium) {
            do {
                try await networkClient.deleteProductFromBasket(productID: productID)
            } catch {
                logger.error(error)
            }
        }
    }
}

// MARK: - Helpers

extension BasketViewModel {

    @MainActor
    private func fetchData() {
        state.screenState = .loading
        Task {
            do {
                let products = try await networkClient.fetchBasketProducts()
                cartService.saveProductsBasket(products.compactMap {
                    guard let id = $0.id, let count = $0.realCount else { return nil }
                    return .init(id: id, count: count)
                })

                let mappedProducts = products.compactMap(factory.convertToProduct)
                // Считаем итоговую сумму
                totalPrice = mappedProducts.reduce(into: 0.0) { resultSum, product in
                    resultSum += product.fullPrice.price
                }

                updateResultSum()
                state.products = mappedProducts
                state.screenState = .content
            } catch {
                logger.error(error)
                state.screenState = .error
            }
        }
    }

    @MainActor
    private func updateResultSum() {
        let difSum = minOrderPrice.price - totalPrice

        state.amountInfo = .init(
            isReady: difSum <= 0,
            resultSumTitle: factory.makePriceFormatting(for: totalPrice),
            needPriceTitle: factory.makePriceFormatting(for: difSum),
            minPriceTitle: minOrderPrice.formattedPrice
        )
    }

    @MainActor
    private func updateNotificationsIfNeeded() {
        // Логика проверки телефона, email и адреса
    }

    @MainActor
    private func updateProductCount(productID: Int, newCount: Int) {
        Task(priority: .medium) {
            do {
                try await networkClient.updateProductCountInBasket(productID: productID, count: newCount)
            } catch {
                logger.error(error)
            }
        }
    }

    @MainActor
    private func changeProductCount(product: ProductModel, increment: Int) {
        guard let index = state.products.firstIndex(where: { $0.id == product.id }) else {
            state.showAlert(.init(
                title: "Ошибка обновления",
                subtitle: "Не получилось обновить счётчик"
            ))
            return
        }

        // Обновляем карточку продукта
        var updatedProduct = product
        let newFullPrice = calculateNewProductFullPrice(
            for: product.itemPrice.price,
            counter: (product.count + increment) * product.magnifier
        )
        let oldFullPrice = updatedProduct.fullPrice.price
        updatedProduct.fullPrice = newFullPrice
        updatedProduct.count += increment
        state.products[index] = updatedProduct

        // Обновляем общий счёт
        totalPrice += newFullPrice.price - oldFullPrice
        updateResultSum()

        // Запрос на обновление счётчика
        updateProductCount(productID: updatedProduct.id, newCount: updatedProduct.count)
    }

    private func calculateNewProductFullPrice(for itemPrice: Double, counter: Int) -> ProductModel.Price {
        let newPrice = itemPrice * Double(counter)
        let formattedNewPrice = factory.makePriceFormatting(for: newPrice)
        return .init(formattedPrice: formattedNewPrice, price: newPrice)
    }
}

// MARK: - MinOrderPrice

extension BasketViewModel {

    struct MinOrderPrice {

        let price: Double
        let formattedPrice: String
    }
}
