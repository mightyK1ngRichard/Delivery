//
//  Created by Dmitriy Permyakov on 06.08.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import DLNetwork
import CartServiceInterface
@preconcurrency import Combine

public struct CartServiceImpl {

    private let networkClient: AnyNetworkClient
    private let logger = DLLogger("Cart Service")
    private let currentProducts = CurrentValueSubject<[BasketProduct], Never>([])

    public init(networkClient: AnyNetworkClient) {
        self.networkClient = networkClient
    }
}

// MARK: - AnyCartService

extension CartServiceImpl: AnyCartService {

    public var basketProductsPublisher: AnyPublisher<[BasketProduct], Never> {
        currentProducts.eraseToAnyPublisher()
    }

    public var currentBasketProducts: [BasketProduct] {
        currentProducts.value
    }

    public func addProductInBasket(body: AddBasketProductPayload) async throws {
        let _ = try await networkClient.request(
            "cart/add",
            method: .post,
            options: .init(
                body: [
                    "product_id": body.productID,
                    "count": body.count
                ],
                required: [.tokenID, .addressID]
            )
        )

        // Добавляем в обсёрвер
        var products = currentProducts.value
        products.append(.init(id: body.productID, count: body.count))
        currentProducts.send(products)
    }

    public func deleteProductFromBasket(productID: Int) async throws {
        let _ = try await networkClient.request(
            "cart/delete",
            method: .post,
            options: .init(
                body: ["product_id": productID],
                required: [.tokenID, .addressID]
            )
        )

        // Удаляем из обсёрвера
        var products = currentProducts.value
        guard let index = products.firstIndex(where: { $0.id == productID }) else {
            return
        }
        products.remove(at: index)
        currentProducts.send(products)
    }

    public func updateProductCountInBasket(productID: Int, count: Int) async throws {
        let _ = try await networkClient.request(
            "cart/update",
            method: .post,
            options: .init(
                body: [
                    "product_id": productID,
                    "count": count
                ],
                required: [.tokenID, .addressID]
            )
        )

        // Удаляем в обсёрвере
        var products = currentProducts.value
        guard let index = products.firstIndex(where: { $0.id == productID }) else {
            return
        }
        products[index] = .init(id: productID, count: count)
        currentProducts.send(products)
    }

    public func saveProductsBasket(_ products: [BasketProduct]) {
        currentProducts.send(products)
    }
}
