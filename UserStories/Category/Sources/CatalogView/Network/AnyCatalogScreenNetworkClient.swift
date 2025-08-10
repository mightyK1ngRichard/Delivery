//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedContractsInterface
import CatalogServiceInterface

protocol AnyCatalogScreenNetworkClient {
    func fetchHitsProducts() async throws -> [ProductEntity]
    func fetchCategories() async throws -> [CategoryEntity]
}
