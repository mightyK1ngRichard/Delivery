//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import OrderServiceInterface

protocol AnyPickAddressScreenNetworkClient {
    func fetchUserAddress() async throws -> [AddressEntity]
}
