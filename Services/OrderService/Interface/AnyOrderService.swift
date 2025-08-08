//
// Created by Dmitriy Permyakov on 06.08.2025.
// Copyright © 2025 Delivery24. All rights reserved.
//

public protocol AnyOrderService: Sendable {
    func makeOrder(body: OrderPayload) async throws
    func forceFetchUserAddresses() async throws -> [AddressEntity]
    func forceFetchUserBonuses() async throws -> Int
}
