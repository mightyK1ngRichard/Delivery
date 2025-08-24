//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import OrderServiceInterface

protocol AnyPickAddressScreenNetworkClient: Sendable {
    func fetchUserAddress() async throws -> [AddressEntity]
    func updateUserAddress(addressID: Int) async throws
}
