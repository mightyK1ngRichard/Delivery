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

    public func forceFetchProfile() async throws(NetworkClientError) -> UserEntity {
        try await networkClient.request(
            "profile",
            method: .post,
            options: .init(required: [.tokenID]),
            decodeTo: UserEntity.self
        ).model
    }

    public func forceFetchOrders() async throws(NetworkClientError) -> [OrderEntity] {
        try await networkClient.request(
            "profile/orders",
            method: .post,
            options: .init(optional: [.tokenID]),
            decodeTo: [OrderEntity].self
        ).model
    }

    public func forceFetchOrderDetails(orderID: Int) async throws(NetworkClientError) -> OrderDetailEntity {
        try await networkClient.request(
            "profile/order",
            method: .post,
            options: .init(
                body: ["order_id": orderID],
                required: [.tokenID]
            ),
            decodeTo: OrderDetailEntity.self
        ).model
    }

    public func forceFetchBasketProducts(addressID: Int) async throws(NetworkClientError) -> [ProductEntity] {
        try await networkClient.request(
            "profile/cart",
            method: .post,
            options: .init(
                body: ["address_id": addressID],
                required: [.tokenID]
            ),
            decodeTo: [ProductEntity].self
        ).model
    }
}
