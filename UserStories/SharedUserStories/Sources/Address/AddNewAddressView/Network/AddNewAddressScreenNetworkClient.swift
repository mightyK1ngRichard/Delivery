//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import DLNetwork

protocol AnyAddNewAddressScreenNetworkClient {
    func saveAddress(payload: SaveAddressPayload) async throws
}

struct AddNewAddressScreenNetworkClient: AnyAddNewAddressScreenNetworkClient {

    let networkClient: AnyNetworkClient

    func saveAddress(payload: SaveAddressPayload) async throws {
        _ = try await networkClient.request(
            "order/address/save",
            method: .post,
            options: RequestOptions(
                body: [
                    "address_id": payload.addressID,
                    "title": payload.title,
                    "city": payload.city,
                    "street": payload.street,
                    "house": payload.house,
                    "flat": payload.flat
                ],
                required: [.tokenID]
            )
        )
    }
}

// MARK: - SaveAddressPayload

struct SaveAddressPayload {

    let addressID: String
    let title: String
    let city: String
    let street: String
    let house: String
    let flat: String
}
