//
//  Created by Dmitriy Permyakov on 06.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import DLCore
import SharedContractsInterface

public protocol AnyProductService: Cachable {
    var stocks: [ProductEntity] { get async throws }
    var exclusives: [ProductEntity] { get async throws }
    var hits: [ProductEntity] { get async throws }
    var news: [ProductEntity] { get async throws }

    func forceFetchStocks() async throws -> [ProductEntity]
    func forceFetchExclusives() async throws -> [ProductEntity]
    func forceFetchHits() async throws -> [ProductEntity]
    func forceFetchNews() async throws -> [ProductEntity]
}
