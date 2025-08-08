//
// Created by Dmitriy Permyakov on 06.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import DLNetwork
import CartServiceInterface

public struct CartServiceImpl {

    private let networkClient: AnyNetworkClient
    private let logger = DLLogger("Cart Service")

    public init(networkClient: AnyNetworkClient) {
        self.networkClient = networkClient
    }
}

// MARK: - AnyCartService

extension CartServiceImpl: AnyCartService {

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
    }
}
