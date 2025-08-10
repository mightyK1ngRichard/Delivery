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

        searchTextSubscribe()
    }
}

// MARK: - Subscription

private extension MainScreenViewModel {

    func searchTextSubscribe() {
        state.$searchText
            .debounce(for: 1, scheduler: DispatchQueue.global(qos: .userInteractive))
            .sink { _ in
            }.store(in: &store)
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
//        guard let userToken else {
//            output.openAuthScreen()
//            return
//        }
//        output.openPickAddressScreen(token: userToken)
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

    func onTapAddInBasket(id productID: Int, counter: Int, coeff: Int, section: ProductSection) {
        logger.logEvent()

        Task { @MainActor in

            do {
                try await networkClient.addProductInBasket(productID: productID, count: counter)
                output?.mainScreenIncrementCartCount()
            } catch {
                logger.error(error)
                output?.mainScreenShowAlert(
                    with: .init(title: "Ошибка добавления в корзину", subtitle: error.localizedDescription)
                )
            }
        }
    }

    func onTapPlusInBasket(productID: Int, counter: Int, coeff: Int, section: ProductSection) {
        logger.logEvent()

        let networkClient = self.networkClient
        let logger = self.logger
        Task.detached(priority: .high) {
            do {
                try await networkClient.updateProductCountInBasket(productID: productID, count: counter)
            } catch {
                logger.error(error)
            }
        }
    }

    func onTapMinusInBasket(productID: Int, counter: Int, coeff: Int, section: ProductSection) {
        logger.logEvent()

        let networkClient = self.networkClient
        let logger = self.logger
        Task.detached(priority: .high) {
            do {
                try await networkClient.updateProductCountInBasket(productID: productID, count: counter)
            } catch {
                logger.error(error)
            }
        }
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
}

// MARK: - FetchResult

private enum FetchResult: Sendable {

    case sections([(ProductSection, [ProductModel])])
    case banners([BannerPage])
    case popcats([PopcatModel])
}
