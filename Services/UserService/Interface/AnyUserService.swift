//
//  Created by Dmitriy Permyakov on 06.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import DLCore
import SharedContractsInterface
import DLNetwork
import Combine

public protocol AnyUserService: Sendable, Cachable {

    func userData() async throws -> UserEntity
    func forceFetchProfile() async throws(NetworkClientError) -> UserEntity
    func forceFetchOrders() async throws(NetworkClientError) -> [OrderEntity]
    func forceFetchOrderDetails(orderID: Int) async throws(NetworkClientError) -> OrderDetailEntity
    func forceFetchBasketProducts() async throws(NetworkClientError) -> [ProductEntity]
    func getNotificationWarnings() async throws -> [NotificationWarning]

    var userPublisher: AnyPublisher<UserEntity?, Never> { get }
    var addressPublisher: AnyPublisher<String?, Never> { get }
    func setAddressTitle(_ title: String)
}
