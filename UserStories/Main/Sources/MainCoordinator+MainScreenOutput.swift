//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Coordinator
import DLCore
import SharedUserStories

extension MainCoordinator: MainScreenOutput {

    func mainScreenOpenProductDetatails(product: ProductModel) {
        logger.logEvent()
        router.push(.product(product))
    }

    func mainScreenOpenAllProducts(sectionTitle: String, products: [ProductModel]) {
        logger.logEvent()
        router.push(.lookAll(navigationTitle: sectionTitle, products: products))
    }

    func mainScreenOpenPopcats(id: Int, title: String) {
        logger.logEvent()
    }

    func mainScreenOpenPickAddressScreen() {
        logger.logEvent()
        router.present(.addressFlow)
    }

    func mainScreenOpenAuthScreen() {
        logger.logEvent()
    }

    func mainScreenAddProductToBasket(product: ProductModel, count: Int) {
        logger.logEvent()
    }

    func mainScreenIncrementProductCountInBasket(productID: Int, count: Int) {
        logger.logEvent()
    }

    func mainScreenDecrementProductCountInBasket(productID: Int, count: Int) {
        logger.logEvent()
    }
}
