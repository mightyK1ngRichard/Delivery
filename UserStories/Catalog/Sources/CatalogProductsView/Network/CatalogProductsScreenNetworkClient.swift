//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import CatalogServiceInterface

protocol AnyCatalogProductsScreenNetworkClient {
    func fetchCategoryProducts(categoryID: Int) async throws -> [CategoryProductEntity]
}

struct CatalogProductsScreenNetworkClient: AnyCatalogProductsScreenNetworkClient {

    let catalogService: AnyCategoryService

    func fetchCategoryProducts(categoryID: Int) async throws -> [CategoryProductEntity] {
        try await catalogService.categoryProducts(categoryID: categoryID)
    }
}
