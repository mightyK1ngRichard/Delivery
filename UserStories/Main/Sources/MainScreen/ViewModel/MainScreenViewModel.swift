//
//  Created by Dmitriy Permyakov on 13.06.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Combine
import SwiftUI
import DLCore
import SharedContractsInterface
import DesignSystem
import SharedUserStories
import UserServiceInterface
import CartServiceInterface

final class MainScreenViewModel: Sendable {

    private let state: MainScreenViewState
    private let userService: AnyUserService
    private let cartService: AnyCartService
    private let networkClient: AnyMainScreenNetworkClient
    private let factory: AnyMainScreenFactory
    @MainActor
    private weak var output: MainScreenOutput?

    private let logger = DLLogger("Main Screen ViewModel")
    @MainActor
    private var store: Set<AnyCancellable> = []

    @MainActor
    init(
        state: MainScreenViewState,
        userService: AnyUserService,
        cartService: AnyCartService,
        networkClient: AnyMainScreenNetworkClient,
        factory: AnyMainScreenFactory,
        output: MainScreenOutput
    ) {
        self.state = state
        self.userService = userService
        self.cartService = cartService
        self.networkClient = networkClient
        self.factory = factory
        self.output = output

        userService.userPublisher
            .receive(on: RunLoop.main)
            .sink { user in
                state.balance = user?.balance
            }
            .store(in: &store)

        userService.addressPublisher
            .receive(on: RunLoop.main)
            .sink { title in
                state.addressTitle = title
            }
            .store(in: &store)

        cartService.basketProductsPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { products in
                state.selectedProducts = Set(products.map(\.id))
                products.forEach { product in
                    for (sectionIndex, section) in state.sections.enumerated() {
                        if let productIndex = section.products.firstIndex(where: { $0.id == product.id }) {
                            let item = state.sections[sectionIndex].products[productIndex]
                            state.sections[sectionIndex].products[productIndex].count = product.count * item.magnifier
                            continue
                        }
                    }
                }
            }
            .store(in: &store)
    }
}

// MARK: - MainViewOutput

extension MainScreenViewModel: MainScreenViewOutput {

    func onFirstAppear() {
        logger.logEvent()
        state.screenState = .loading
        Task {
            await fetchData()
        }
    }

    func refresh() async {
        logger.logEvent()
        state.screenState = .loading
        Task {
            await fetchData()
        }
    }

    func onTapReload() {
        logger.logEvent()
        state.screenState = .loading
        Task {
            await fetchData()
        }
    }

    func onTapSelectAddress() {
        logger.logEvent()
        output?.mainScreenOpenPickAddressScreen()
    }

    func onTapProductCard(product: ProductModel) {
        logger.logEvent()
        output?.mainScreenOpenProductDetatails(product: product)
    }

    func onTapSectionLookMore(section: ProductSection) {
        logger.logEvent()

        guard let object = state.sections.first(where: { $0.section.id == section.id }) else {
            logger.error("Секция не найдена")
            return
        }

        output?.mainScreenOpenAllProducts(sectionTitle: object.section.title, products: object.products)
    }

    func onTapPopcatsCell(id: Int, title: String) {
        logger.logEvent()
        output?.mainScreenOpenPopcats(id: id, title: title)
    }

    func onTapLike(id: Int, isLike: Bool) {
        logger.logEvent()
    }

    func onTapAddInBasket(product: ProductModel, counter: Int, coeff: Int, section: ProductSection) {
        logger.logEvent()

        let alertModel = AlertModel(
            title: "Ошибка добавления в корзину",
            subtitle: "Не удалось добавить товар в корзину. Попробуйте еще раз позже."
        )
        guard let (sectionIndex, productIndex) = getProductIndecices(product, sectionID: section.id) else {
            state.showAlert(alertModel)
            return
        }

        state.sections[sectionIndex].products[productIndex].count = 1

        Task {
            do {
                try await networkClient.addProductInBasket(productID: product.id, count: 1)
            } catch {
                logger.error(error)
                state.showAlert(alertModel)
            }
        }
    }

    func onTapPlusInBasket(product: ProductModel, counter: Int, coeff: Int, section: ProductSection) {
        logger.logEvent()

        changeProductCount(
            product: product,
            sectionID: section.id,
            increment: 1,
            alert: AlertModel(
                title: "Ошибка увеличения количества торара",
                subtitle: "Не удалось увеличить количество товара в корзине. Попробуйте еще раз позже."
            )
        )
    }

    func onTapMinusInBasket(product: ProductModel, counter: Int, coeff: Int, section: ProductSection) {
        logger.logEvent()

        changeProductCount(
            product: product,
            sectionID: section.id,
            increment: -1,
            alert: AlertModel(
                title: "Ошибка уменьшения количества торара",
                subtitle: "Не удалось уменьшить количество товара в корзине. Попробуйте еще раз позже."
            )
        )
    }
}

// MARK: - Network

extension MainScreenViewModel {

    @MainActor
    private func fetchData() async {
        let basketProducts = cartService.currentBasketProducts.reduce(into: [:]) { accum, product in
            accum[product.id] = product.count
        }
        state.selectedProducts = Set(cartService.currentBasketProducts.map(\.id))

        do {
            try await withThrowingTaskGroup(of: FetchResult.self) { group in
                try Task.checkCancellation()

                group.addTask {
                    try Task.checkCancellation()

                    let sections = try await self.networkClient.fetchProducts()
                    return .sections(sections.map { section, products in
                        let result: [ProductModel] = products.compactMap { product in
                            guard let id = product.id,
                                  var mappedProduct = self.factory.convertToProduct(from: product)
                            else { return nil }

                            if let count = basketProducts[id] {
                                mappedProduct.count = count
                            }

                            return mappedProduct
                        }
                        return .init(section: section, products: result)
                    })
                }

                group.addTask {
                    try Task.checkCancellation()

                    let banners = try await self.networkClient.fetchBanners()
                    return .banners(banners.compactMap(self.factory.convertToBannerPage))
                }

                group.addTask {
                    try Task.checkCancellation()

                    let cards = try await self.networkClient.fetchPopCards()
                    return .popcats(cards.compactMap(self.factory.convertToPopcat))
                }

                var sections: [MainScreenViewState.Section] = []
                var banners: [BannerPage] = []
                var popcats: [PopcatModel] = []

                for try await result in group {
                    switch result {
                    case .sections(let value): sections = value
                    case .banners(let value): banners = value
                    case .popcats(let value): popcats = value
                    }
                }

                state.sections = sections.sorted { $0.section > $1.section }
                state.banners = banners
                state.popcats = popcats
                state.screenState = .content
            }
        } catch is CancellationError {
            logger.error("Задача отменена")
            state.screenState = .error
        } catch {
            logger.error(error.localizedDescription)
            state.screenState = .error
        }
    }

    @MainActor
    private func getProductIndecices(_ product: ProductModel, sectionID: Int) -> (Int, Int)? {
        guard let sectionIndex = state.sections.firstIndex(where: { $0.section.id == sectionID }),
              let productIndex = state.sections[sectionIndex].products.firstIndex(of: product)
        else { return nil }

        return (sectionIndex, productIndex)
    }

    @MainActor
    private func changeProductCount(
        product: ProductModel,
        sectionID: Int,
        increment: Int,
        alert: AlertModel
    ) {
        guard let (sectionIndex, productIndex) = getProductIndecices(product, sectionID: sectionID) else {
            state.showAlert(alert)
            return
        }

        state.sections[sectionIndex].products[productIndex].count += increment

        Task {
            do {
                try await networkClient.updateProductCountInBasket(
                    productID: product.id,
                    count: product.count + increment
                )
            } catch {
                logger.error(error)
                state.showAlert(alert)
            }
        }
    }
}

// MARK: - FetchResult

private enum FetchResult: Sendable {

    case sections([MainScreenViewState.Section])
    case banners([BannerPage])
    case popcats([PopcatModel])
}
