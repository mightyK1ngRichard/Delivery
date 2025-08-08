//
// Created by Dmitriy Permyakov on 06.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLNetwork
import DLCore
import BannerServiceInterface

public struct BannersServiceImpl {

    private let networkClient: AnyNetworkClient
    private let cacheStore = CacheStore<[BannerEntity]>(cacheLifeTimeSeconds: 2.5 * 60)

    public init(networkClient: AnyNetworkClient) {
        self.networkClient = networkClient
    }
}

// MARK: - AnyBannersService

extension BannersServiceImpl: AnyBannersService {

    public var banners: [BannerEntity] {
        get async throws {
            try await fetchFromStoreOrNetwork(storage: cacheStore, request: forceFetchBanners)
        }
    }

    public func forceFetchBanners() async throws -> [BannerEntity] {
        try await networkClient.request(
            "main/banners",
            method: .post,
            options: .init(),
            decodeTo: [BannerEntity].self
        ).model
    }
}
