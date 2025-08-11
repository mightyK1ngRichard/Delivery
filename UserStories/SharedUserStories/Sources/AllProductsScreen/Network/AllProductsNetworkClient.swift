//
//  Created by Dmitriy Permyakov on 11.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import CartServiceInterface

struct AllProductsNetworkClient: AnyAllProductsNetworkClient {

    let cartService: AnyCartService

    func addProductInBasket(productID: Int, count: Int) async throws {
        try await cartService.addProductInBasket(body: .init(
            productID: productID,
            count: count
        ))
    }

    func updateProductCountInBasket(productID: Int, count: Int) async throws {
        try await cartService.updateProductCountInBasket(productID: productID, count: count)
    }
}
