//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DLCore
import Coordinator
import SharedUserStories

final class MainCoordinator: Navigatable {

    let router: Router<MainRoutes>
    let logger = DLLogger("Main Coordinator")

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
            MainScreenAssembly
                .assemble(output: self)
        case let .product(product):
            ProductDetailsAssembly
                .assemble(product: product, output: self)
        case let .lookAll(navigationTitle, products):
            AllProductsScreenAssembly
                .assemble(products: products, navigationTitle: navigationTitle, output: self)
        }
    }
}

// MARK: - ProductDetailsScreenOutput

extension MainCoordinator: ProductDetailsScreenOutput {}

// MARK: - AllProductsScreenOutput

extension MainCoordinator: AllProductsScreenOutput {

    func didTapOpenProuctDetails(with product: ProductModel) {
        logger.logEvent()
        router.push(.product(product))
    }
}
