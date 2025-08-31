//
//  Created by Dmitriy Permyakov on 11.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedContractsInterface
import UserServiceInterface

protocol AnyBootIteractor: Sendable {
    func initialize() async -> Bool
    func fetchInitialData() async -> (Bool, [ProductEntity])
}
