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

final class MainScreenViewModel {

    private let state: MainScreenViewState
    private let networkClient: AnyMainScreenNetworkClient
    private let factory: AnyMainScreenFactory
    private weak var output: MainScreenOutput?

    private let logger = DLLogger("Main Screen ViewModel")
    private var store: Set<AnyCancellable> = []

    @MainActor
    init(
        state: MainScreenViewState,
        networkClient: AnyMainScreenNetworkClient,
        factory: AnyMainScreenFactory,
        output: MainScreenOutput
    ) {
        self.state = state
        self.networkClient = networkClient
        self.factory = factory
        self.output = output
    }
}

// MARK: - MainViewOutput

extension MainScreenViewModel: MainScreenViewOutput {

    func onFirstAppear() {
        logger.logEvent()
        fetchData()
    }

    func onTapReload() {
        logger.logEvent()
        fetchData()
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
    private func fetchData() {
        state.screenState = .loading

        Task {
            do {
                try await withThrowingTaskGroup(of: FetchResult.self) { group in
                    let networkClient = self.networkClient
                    let factory = self.factory

                    group.addTask {
                        let sections = try await networkClient.fetchProducts()
                        return .sections(sections.map { section, products in
                            (section, products.compactMap(factory.convertToProduct))
                        })
                    }

                    group.addTask {
                        let banners = try await networkClient.fetchBanners()
                        return .banners(banners.compactMap(factory.convertToBannerPage))
                    }

                    group.addTask {
                        let cards = try await networkClient.fetchPopCards()
                        return .popcats(cards.compactMap(factory.convertToPopcat))
                    }

                    var sections: [(ProductSection, [ProductModel])] = []
                    var banners: [BannerPage] = []
                    var popcats: [PopcatModel] = []

                    for try await result in group {
                        switch result {
                        case .sections(let value): sections = value
                        case .banners(let value): banners = value
                        case .popcats(let value): popcats = value
                        }
                    }

                    state.sections = sections.sorted { $0.0 > $1.0 }
                    state.banners = banners
                    state.popcats = popcats
                    state.screenState = .content
                }
            } catch {
                logger.error(error)
                state.screenState = .error
            }
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

    case sections([(ProductSection, [ProductModel])])
    case banners([BannerPage])
    case popcats([PopcatModel])
}
