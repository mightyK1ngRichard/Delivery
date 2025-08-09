//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import UserServiceInterface

struct OrdersScreenNetworkClient: AnyOrdersScreenNetworkClient {

    let userService: AnyUserService

    func forceFetchOrders() async throws -> [OrderEntity] {
        try await userService.forceFetchOrders()
    }
}
