//
//  Created by Dmitriy Permyakov on 13.06.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Combine
import SwiftUI
import DLCore
import SharedContractsInterface
import DesignSystem

final class MainScreenViewModel {

    private let state: MainScreenViewState
    private let networkClient: AnyMainScreenNetworkClient
    private let factory: AnyMainScreenFactory
    weak var output: MainScreenOutput?

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

    func onTapProductCard(product: Product) {
        logger.logEvent()
        output?.openProductDetatails(product: product)
    }

    func onTapSectionLookMore(section: ProductSection) {
        logger.logEvent()
        guard let object = state.sections.first(where: { $0.section == section }) else {
            logger.error("Секция не найдена")
            return
        }

        output?.openAllProducts(sectionTitle: object.section.title, products: object.products)
    }

    func onTapPopcatsCell(id: Int, title: String) {
        logger.logEvent()
        output?.openPopcats(id: id, title: title)
    }

    func onTapLike(id: Int, isLike: Bool) {
        logger.logEvent()
    }

    func onTapAddInBasket(id productID: Int, counter: Int, coeff: Int, section: ProductSection) {
        logger.logEvent()

        Task { @MainActor in

            do {
                try await networkClient.addProductInBasket(productID: productID, count: counter)
                output?.incrementCartCount()
            } catch {
                logger.error(error)
                output?.showAlert(title: "Ошибка добавления в корзину", message: error.localizedDescription)
            }
        }
    }

    func onTapPlusInBasket(productID: Int, counter: Int, coeff: Int, section: ProductSection) {
        logger.logEvent()

        Task.detached(priority: .high) { [weak self] in
            do {
                try await self?.networkClient.updateProductCountInBasket(productID: productID, count: counter)
            } catch {
                self?.logger.error(error)
            }
        }
    }

    func onTapMinusInBasket(productID: Int, counter: Int, coeff: Int, section: ProductSection) {
        logger.logEvent()

        Task.detached(priority: .high) { [weak self] in
            do {
                try await self?.networkClient.updateProductCountInBasket(productID: productID, count: counter)
            } catch {
                self?.logger.error(error)
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
                try await withThrowingTaskGroup(of: (String, Any).self) { group in
                    // Получаем продукты всех категорий
                    group.addTask {
                        let sections = try await self.networkClient.fetchProducts()
                        return ("sections", sections.map {
                            return ($0, $1.compactMap(self.factory.convertToProduct))
                        })
                    }

                    // Получаем баннеры
                    group.addTask {
                        let banners = try await self.networkClient.fetchBanners()
                        return ("banners", banners.compactMap(self.factory.convertToBannerPage))
                    }

                    // Получаем популярные категории
                    group.addTask {
                        let cards = try await self.networkClient.fetchPopCards()
                        return ("popcats", cards.compactMap(self.factory.convertToPopcat))
                    }

                    // Собираем результаты
                    var results = [String: Any]()
                    for try await (key, value) in group {
                        results[key] = value
                    }

                    // Извлекаем результаты из словаря
                    guard let sections = results["sections"] as? [(ProductSection, [Product])],
                          let banners = results["banners"] as? [BannerPage],
                          let popcats = results["popcats"] as? [Popcat]
                    else {
                        assertionFailure("Неожиданный формат результатов")
                        return
                    }

                    state.sections = sections
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
