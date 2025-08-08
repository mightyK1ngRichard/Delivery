//
// Created by Dmitriy Permyakov on 06.08.2025.
// Copyright © 2025 Delivery24. All rights reserved.
//

import DLCore

public protocol AnyPopcatsService: Cachable {
    var popcats: [PopcatsEntity] { get async throws }
    func forceFetchPopcats() async throws -> [PopcatsEntity]
}
