//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import CatalogServiceInterface
import CartServiceInterface

struct CatalogProductsScreenNetworkClient: AnyCatalogProductsScreenNetworkClient {

    let catalogService: AnyCategoryService
    let cartService: AnyCartService

    func fetchCategoryProducts(categoryID: Int) async throws -> [CategoryProductEntity] {
        try await catalogService.categoryProducts(categoryID: categoryID)
    }

    func addProductInBasket(productID: Int, count: Int) async throws {
        try await cartService.addProductInBasket(body: .init(productID: productID, count: count))
    }

    func updateProductCountInBasket(productID: Int, count: Int) async throws {
        try await cartService.updateProductCountInBasket(productID: productID, count: count)
    }
}
