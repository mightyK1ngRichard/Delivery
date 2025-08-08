//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DLCore
import Coordinator

@MainActor
final class MainCoordinator: Navigatable {

    let router: Router<MainRoutes>
    private let logger = DLLogger("Main Coordinator")

    init(router: Router<MainRoutes>) {
        self.router = router
    }

    func run() -> some View {
        destination(.main)
    }

    @ViewBuilder
    func destination(_ route: MainRoutes) -> some View {
        switch route {
        case .main:
            MainScreenAssembly.assemble(output: self)
        case let .product(product):
            ProductDetailsAssembly.assemble(product: product, output: self)
        }
    }
}

// MARK: - MainScreenOutput

extension MainCoordinator: MainScreenOutput {

    func openProductDetatails(product: Product) {
        logger.logEvent()
        router.push(.product(product))
    }

    func openAllProducts(sectionTitle: String, products: [Product]) {
        logger.logEvent()
    }

    func openPopcats(id: Int, title: String) {
        logger.logEvent()
    }

    func openPickAddressScreen() {
        logger.logEvent()
    }

    func openAuthScreen() {
        logger.logEvent()
    }

    func showAlert(title: String, message: String) {
        logger.logEvent()
    }

    func showAuthAlert(title: String, message: String) {
        logger.logEvent()
    }

    func showAddAddressAlert(title: String, message: String, token: String) {
        logger.logEvent()
    }

    func incrementCartCount() {
        logger.logEvent()
    }

    func decrementCartCount() {
        logger.logEvent()
    }

    func addProductToBasket(product: Product, count: Int) {
        logger.logEvent()
    }

    func incrementProductCountInBasket(productID: Int, count: Int) {
        logger.logEvent()
    }

    func decrementProductCountInBasket(productID: Int, count: Int) {
        logger.logEvent()
    }
}

// MARK: - ProductDetailsScreenOutput

extension MainCoordinator: ProductDetailsScreenOutput {}
