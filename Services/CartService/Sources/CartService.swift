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
    private let logger = DLLogger("CartService")

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
            body: .basic([
                "address_id": body.addressID,
                "product_id": body.productID,
                "count": body.count
            ])
        )
    }

    public func deleteProductFromBasket(productID: Int, addressID: Int) async throws {
        let _ = try await networkClient.request(
            "cart/delete",
            method: .post,
            body: .basic([
                "address_id": addressID,
                "product_id": productID
            ])
        )
    }

    public func updateProductCountInBasket(
        productID: Int,
        count: Int,
        addressID: Int
    ) async throws {
        let _ = try await networkClient.request(
            "cart/update",
            method: .post,
            body: .basic([
                "address_id": addressID,
                "product_id": productID,
                "count": count
            ])
        )
    }
}
