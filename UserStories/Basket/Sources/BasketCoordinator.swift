//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DLCore
import Coordinator
import SharedUserStories

enum BasketRoute: Identifiable, Hashable {
    case main
    case makeOrder(orderModel: OrderModel)
    case productDetails(product: ProductModel)

    var id: Self { self }
}

final class BasketCoordinator: Navigatable {

    let router: Router<BasketRoute>
    let logger = DLLogger("Basket Coordinator")

    init(router: Router<BasketRoute>) {
        self.router = router
    }

    func run() -> some View {
        destination(.main)
    }

    @ViewBuilder
    func destination(_ route: BasketRoute) -> some View {
        switch route {
        case .main:
            BasketAssembly.assemble(output: self)
        case let .productDetails(product):
            ProductDetailsAssembly
                .assemble(product: product, output: self)
        case let .makeOrder(orderModel):
            FormOrderAssembly
                .assemble(orderModel: orderModel, output: self)
        }
    }

    deinit {
        print("[DEBUG]: \(#function)")
    }
}

// MARK: - BasketScreenOutput

extension BasketCoordinator: BasketScreenOutput {

    func basketScreenDidOpenProductDetails(product: ProductModel) {
        logger.logEvent()
        router.push(.productDetails(product: product))
    }

    func basketScreenDidOpenCatalog() {
        logger.logEvent()
    }

    func basketScreenDidOpenMakeOrderScreen(orderModel: OrderModel) {
        logger.logEvent()
        router.push(.makeOrder(orderModel: orderModel))
    }

    func basketScreenDidShowAlert(with alert: AlertModel) {
        logger.logEvent()
    }
}

// MARK: - ProductDetailsScreenOutput

extension BasketCoordinator: ProductDetailsScreenOutput {
}

// MARK: - FormOrderScreenOutput

extension BasketCoordinator: FormOrderScreenOutput {
}
