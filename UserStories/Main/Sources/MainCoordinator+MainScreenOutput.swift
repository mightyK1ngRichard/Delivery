//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Coordinator
import DLCore
import SharedUserStories

extension MainCoordinator: MainScreenOutput {

    func openProductDetatails(product: ProductModel) {
        logger.logEvent()
        router.push(.product(product))
    }

    func openAllProducts(sectionTitle: String, products: [ProductModel]) {
        logger.logEvent()
        router.push(.lookAll(navigationTitle: sectionTitle, products: products))
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

    func addProductToBasket(product: ProductModel, count: Int) {
        logger.logEvent()
    }

    func incrementProductCountInBasket(productID: Int, count: Int) {
        logger.logEvent()
    }

    func decrementProductCountInBasket(productID: Int, count: Int) {
        logger.logEvent()
    }
}
