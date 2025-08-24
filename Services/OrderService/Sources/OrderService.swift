//
//  Created by Dmitriy Permyakov on 06.08.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import DLCore
import DLNetwork
import Foundation
import OrderServiceInterface

public struct OrderServiceImpl {

    private let networkStore: AnyNetworkStore
    private let networkClient: AnyNetworkClient
    private let logger = DLLogger("Order Service")

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

        if let mainAddress = model.first(where: { $0.isMain == 1 }), let id = mainAddress.id {
            await networkStore.setAddress(.init(id: id, title: mainAddress.title))
        }

        return model
    }

    public func makeOrder(body: OrderPayload) async throws {
        let productsDict = Dictionary(uniqueKeysWithValues: body.products.map {
            (String($0.id), $0.count)
        })

        let _ = try await networkClient.request(
            "order/add",
            method: .post,
            options: .init(
                body: [
                    "bonus": body.bonus,
                    "payment_type": body.paymentType,
                    "products": productsDict
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
