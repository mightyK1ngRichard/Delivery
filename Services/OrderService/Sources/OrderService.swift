//
// Created by Dmitriy Permyakov on 06.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import DLCore
import DLNetwork
import Foundation
import OrderServiceInterface

public struct OrderServiceImpl {

    private let logger = DLLogger("Order Service")
    private let networkStore: AnyNetworkStore
    private let networkClient: AnyNetworkClient

    public init(
        networkClient: AnyNetworkClient,
        networkStore: AnyNetworkStore
    ) {
        self.networkClient = networkClient
        self.networkStore = networkStore
    }
}

// MARK: - AnyOrderService

extension OrderServiceImpl: AnyOrderService {

    public func forceFetchUserAddresses() async throws -> [AddressEntity] {
        let model = try await networkClient.request(
            "order/addresses",
            method: .post,
            options: .init(required: [.tokenID]),
            decodeTo: [AddressEntity].self
        ).model

        if let mainAddressID = model.first(where: { $0.isMain == 1 })?.id {
            await networkStore.setAddressID(mainAddressID)
        }

        return model
    }

    public func makeOrder(body: OrderPayload) async throws {
        let _ = try await networkClient.request(
            "order/add",
            method: .post,
            options: .init(
                body: [
                    "bonus": body.bonus,
                    "products": Dictionary(uniqueKeysWithValues: body.products.map {
                        ($0.id, $0.count)
                    })
                ],
                required: [.tokenID, .addressID]
            )
        )
    }

    public func forceFetchUserBonuses() async throws -> Int {
        try await networkClient.request(
            "order/bonuses",
            method: .post,
            options: .init(required: [.tokenID]),
            decodeTo: Int.self
        ).model
    }
}
