//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import UserServiceInterface
import CartServiceInterface
import SharedContractsInterface

struct BasketNetworkClient: AnyBasketNetworkClient {

    let userService: AnyUserService
    let cartService: AnyCartService

    func fetchBasketProducts() async throws -> [ProductEntity] {
        try await userService.forceFetchBasketProducts()
    }

    func deleteProductFromBasket(productID: Int) async throws {
        try await cartService.deleteProductFromBasket(productID: productID)
    }

    func updateProductCountInBasket(productID: Int, count: Int) async throws {
        try await cartService.updateProductCountInBasket(productID: productID, count: count)
    }
}
