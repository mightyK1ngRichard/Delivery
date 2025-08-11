//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedContractsInterface
import CatalogServiceInterface
import ProductServiceInterface
import CartServiceInterface

struct CatalogScreenNetworkClient: AnyCatalogScreenNetworkClient {

    let catalogService: AnyCategoryService
    let productService: AnyProductService
    let cartService: AnyCartService

    func fetchHitsProducts() async throws -> [ProductEntity] {
        try await productService.hits
    }

    func fetchCategories() async throws -> [CategoryEntity] {
        try await catalogService.categories()
    }

    func addProductInBasket(productID: Int, count: Int) async throws {
        try await cartService.addProductInBasket(body: .init(productID: productID, count: count))
    }

    func updateProductCountInBasket(productID: Int, count: Int) async throws {
        try await cartService.updateProductCountInBasket(productID: productID, count: count)
    }
}
