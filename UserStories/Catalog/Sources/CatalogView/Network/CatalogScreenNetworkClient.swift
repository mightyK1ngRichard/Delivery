//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedContractsInterface
import CatalogServiceInterface
import ProductServiceInterface

struct CatalogScreenNetworkClient: AnyCatalogScreenNetworkClient {

    let catalogService: AnyCategoryService
    let productService: AnyProductService

    func fetchHitsProducts() async throws -> [ProductEntity] {
        try await productService.hits
    }

    func fetchCategories() async throws -> [CategoryEntity] {
        try await catalogService.categories()
    }
}
