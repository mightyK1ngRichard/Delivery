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
    private let networkStore: AnyNetworkStore
    private let cacheStore = CacheStore<UserEntity>(cacheLifeTimeSeconds: 2.5 * 60)

    private let logger = DLLogger("User Service")

    public init(networkClient: AnyNetworkClient, networkStore: AnyNetworkStore) {
        self.networkClient = networkClient
        self.networkStore = networkStore
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

    public func forceFetchBasketProducts() async throws(NetworkClientError) -> [ProductEntity] {
        try await networkClient.request(
            "profile/cart",
            method: .post,
            options: .init(
                required: [.tokenID, .addressID]
            ),
            decodeTo: [ProductEntity].self
        ).model
    }

    public func getNotificationWarnings() async throws -> [NotificationWarning] {
        let user = try await userData()

        var notifications: [NotificationWarning] = []
        // Проверка существования адреса
        if await networkStore.addressID == nil {
            notifications.append(.needAddress)
        }

        // Проверка email
        if user.verifyFlagEmail == 1 {
            notifications.append(.needEmailVerification)
        }

        // Проверка телефона
        if user.verifyFlagPhone == 1 {
            notifications.append(.needPhoneVerification)
        }

        return notifications
    }
}
