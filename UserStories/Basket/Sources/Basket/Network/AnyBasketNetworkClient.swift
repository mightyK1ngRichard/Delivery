//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedContractsInterface

protocol AnyBasketNetworkClient: Sendable {
    func fetchBasketProducts() async throws -> [ProductEntity]
    func deleteProductFromBasket(productID: Int) async throws
    func updateProductCountInBasket(productID: Int, count: Int) async throws
}
