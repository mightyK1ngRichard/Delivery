//
// Created by Dmitriy Permyakov on 27.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import DLNetwork
import UserServiceInterface
import SharedContractsInterface

// MARK: - UserService

public struct UserServiceImpl {

    private let networkClient: AnyNetworkClient
    private let cacheStore = CacheStore<UserEntity>(cacheLifeTimeSeconds: 2.5 * 60)

    private let logger = DLLogger("User Service")

    public init(networkClient: AnyNetworkClient) {
        self.networkClient = networkClient
    }
}

// MARK: - AnyUserService

extension UserServiceImpl: AnyUserService {

    public func userData() async throws -> UserEntity {
        try await fetchFromStoreOrNetwork(storage: cacheStore) {
            try await forceFetchProfile()
        }
    }

    public func forceFetchProfile() async throws -> UserEntity {
        let data = try await networkClient.request(
            "profile/user",
            method: .post,
            options: .init(optional: [.tokenID])
        ).data

        do {
            return try JSONDecoder().decode(UserEntity.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }

    public func forceFetchOrders() async throws -> [OrderEntity] {
        let data = try await networkClient.request(
            "profile/orders",
            method: .post,
            options: .init(optional: [.tokenID])
        ).data

        do {
            return try JSONDecoder().decode([OrderEntity].self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }

    public func forceFetchOrderDetails(orderID: Int) async throws -> OrderDetailEntity {
        let data = try await networkClient.request(
            "profile/order",
            method: .post,
            options: .init(
                body: ["order_id": orderID],
                required: [.tokenID]
            )
        ).data

        do {
            return try JSONDecoder().decode(OrderDetailEntity.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }

    public func forceFetchBasketProducts(addressID: Int) async throws -> [ProductEntity] {
        let data = try await networkClient.request(
            "profile/cart",
            method: .post,
            options: .init(
                body: ["address_id": addressID],
                required: [.tokenID]
            )
        ).data

        do {
            return try JSONDecoder().decode([ProductEntity].self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
