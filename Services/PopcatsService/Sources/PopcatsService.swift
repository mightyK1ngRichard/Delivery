//
// Created by Dmitriy Permyakov on 06.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import DLNetwork
import PopcatsServiceInterface

public struct PopcatsServiceImpl {

    private let networkClient: AnyNetworkClient
    private let cacheStore = CacheStore<[PopcatsEntity]>(cacheLifeTimeSeconds: 5 * 60)
    private let logger = DLLogger("Popcats Service")

    public init(networkClient: AnyNetworkClient) {
        self.networkClient = networkClient
    }
}

// MARK: - AnyPopcatsService

extension PopcatsServiceImpl: AnyPopcatsService {

    public var popcats: [PopcatsEntity] {
        get async throws {
            try await fetchFromStoreOrNetwork(storage: cacheStore, request: forceFetchPopcats)
        }
    }

    public func forceFetchPopcats() async throws -> [PopcatsEntity] {
        try await networkClient.request(
            "main/popcats",
            method: .post,
            options: .init(),
            decodeTo: [PopcatsEntity].self
        ).model
    }
}
