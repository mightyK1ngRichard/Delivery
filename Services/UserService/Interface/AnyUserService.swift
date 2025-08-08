//
//  Created by Dmitriy Permyakov on 06.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import DLCore
import SharedContractsInterface

public protocol AnyUserService: Cachable {
    func userData() async throws -> UserEntity
    func forceFetchProfile() async throws -> UserEntity
    func forceFetchOrders() async throws -> [OrderEntity]
    func forceFetchOrderDetails(orderID: Int) async throws -> OrderDetailEntity
    func forceFetchBasketProducts(addressID: Int) async throws -> [ProductEntity]
}
