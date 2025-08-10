//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import OrderServiceInterface

struct PickAddressScreenNetworkClient: AnyPickAddressScreenNetworkClient {

    let orderService: AnyOrderService

    func fetchUserAddress() async throws -> [AddressEntity] {
        try await orderService.forceFetchUserAddresses()
    }
}
