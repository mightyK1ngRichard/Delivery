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
    private let networkClient: AnyNetworkClient

    public init(networkClient: AnyNetworkClient) {
        self.networkClient = networkClient
    }
}

// MARK: - AnyOrderService

extension OrderServiceImpl: AnyOrderService {

    public func forceFetchUserAddresses() async throws -> [AddressEntity] {
        let data = try await networkClient.request(
            "order/addresses",
            method: .post,
            options: .init(required: [.tokenID])
        ).data

        do {
            return try JSONDecoder().decode([AddressEntity].self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
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
        let data = try await networkClient.request(
            "order/bonuses",
            method: .post,
            options: .init(required: [.tokenID])
        ).data

        do {
            return try JSONDecoder().decode(Int.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
