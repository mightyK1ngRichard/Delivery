//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import OrderServiceInterface
import DLNetwork

struct PickAddressScreenNetworkClient: AnyPickAddressScreenNetworkClient {

    let orderService: AnyOrderService
    let networkClient: AnyNetworkClient
    let networkStore: AnyNetworkStore

    func fetchUserAddress() async throws -> [AddressEntity] {
        try await orderService.forceFetchUserAddresses()
    }

    func updateUserAddress(addressID: Int) async throws {
        do {
            let _ = try await networkClient.request(
                "user/update-address",
                method: .post,
                options: RequestOptions(
                    body: [
                        "address_id": addressID
                    ],
                    required: [.tokenID]
                )
            )
//            networkStore.setAddress(.init(id: addressID, title: <#T##String?#>))
        } catch {
            throw error
        }
    }
}
