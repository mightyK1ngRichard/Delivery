//
//  Created by Dmitriy Permyakov on 11.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import CatalogServiceInterface

protocol AnyCatalogProductsScreenNetworkClient {
    func fetchCategoryProducts(categoryID: Int) async throws -> [CategoryProductEntity]
    func addProductInBasket(productID: Int, count: Int) async throws
    func updateProductCountInBasket(productID: Int, count: Int) async throws
}
