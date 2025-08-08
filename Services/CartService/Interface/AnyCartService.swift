//
//  Created by Dmitriy Permyakov on 06.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

public protocol AnyCartService: Sendable {
    func addProductInBasket(body: AddBasketProductPayload) async throws
    func updateProductCountInBasket(productID: Int, count: Int) async throws
    func deleteProductFromBasket(productID: Int) async throws
}
