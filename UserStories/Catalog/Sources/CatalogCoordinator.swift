//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DLCore
import Coordinator
import SharedUserStories
import MainInterface

final class CatalogCoordinator: Navigatable {

    let router: Router<CatalogRoute>
    let logger = DLLogger("Profile Coordinator")

    init(router: Router<CatalogRoute>) {
        self.router = router
    }

    func run() -> some View {
        destination(.main)
    }

    @ViewBuilder
    func destination(_ route: CatalogRoute) -> some View {
        switch route {
        case .main:
            CatalogAssembly
                .assemble(output: self)
        case let .categorySublist(category):
            CategoryListAssembly
                .assemble(category: category, output: self)
        case let .categoryProducts(category, categories):
            CatalogProductsAssembly
                .assemble(category: category, categories: categories, output: self)
        case let .productDetails(product):
            ProductDetailsAssembly.assemble(product: product, output: self)
        }
    }
}

// MARK: - CatalogOutput

extension CatalogCoordinator: CatalogScreenOutput {

    func catalogScreenDidOpenCategoryList(category: CategoryModel) {
        logger.logEvent()
        router.push(.categorySublist(category: category))
    }

    func catalogScreenDidOpenLookAllProducts(navigationTitle: String, products: [ProductModel]) {
        logger.logEvent()
    }

    func catalogScreenDidOpenProductDetails(product: ProductModel) {
        logger.logEvent()
        router.push(.productDetails(product: product))
    }
}

// MARK: - CategoryListScreenOutput

extension CatalogCoordinator: CategoryListScreenOutput {

    func categoryListDidOpenCategoryProductsScreen(category: CategoryModel, categories: [CategoryModel]) {
        logger.logEvent()
        router.push(.categoryProducts(category: category, categories: categories))
    }

    func categoryListDidShowAlert(message: String) {
        logger.logEvent()
    }
}

// MARK: - CatalogProductsOutput

extension CatalogCoordinator: CatalogProductsOutput {

    func catalogProductsOpenProductDetails(product: ProductModel) {
        logger.logEvent()
        router.push(.productDetails(product: product))
    }

    func catalogProductsShowAlertError(message: String) {
        logger.logEvent()
    }
}

// MARK: - ProductDetailsScreenOutput

extension CatalogCoordinator: ProductDetailsScreenOutput {

}
