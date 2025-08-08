//
// Created by Dmitriy Permyakov on 06.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import DLNetwork
import ProductServiceInterface
import SharedContractsInterface

public struct ProductServiceImpl {

    private let networkClient: AnyNetworkClient

    private let stocksStore = CacheStore<[ProductEntity]>(cacheLifeTimeSeconds: .cacheLifeTimeSeconds)
    private let exclusivesStore = CacheStore<[ProductEntity]>(cacheLifeTimeSeconds: .cacheLifeTimeSeconds)
    private let hitsStore = CacheStore<[ProductEntity]>(cacheLifeTimeSeconds: .cacheLifeTimeSeconds)
    private let newsStore = CacheStore<[ProductEntity]>(cacheLifeTimeSeconds: .cacheLifeTimeSeconds)

    private let logger = DLLogger("Product Service")

    public init(networkClient: AnyNetworkClient) {
        self.networkClient = networkClient
    }
}

// MARK: - AnyProductService

extension ProductServiceImpl: AnyProductService {

    public var stocks: [ProductEntity] {
        get async throws {
            try await fetchFromStoreOrNetwork(storage: stocksStore, request: forceFetchStocks)
        }
    }

    public var exclusives: [ProductEntity] {
        get async throws {
            try await fetchFromStoreOrNetwork(storage: exclusivesStore, request: forceFetchExclusives)
        }
    }

    public var hits: [ProductEntity] {
        get async throws {
            try await fetchFromStoreOrNetwork(storage: hitsStore, request: forceFetchHits)
        }
    }

    public var news: [ProductEntity] {
        get async throws {
            try await fetchFromStoreOrNetwork(storage: newsStore, request: forceFetchNews)
        }
    }

    public func forceFetchStocks() async throws -> [ProductEntity] {
        let data = try await networkClient.request(
            "main/actions",
            method: .post,
            options: .init(optional: [.tokenID])
        ).data

        do {
            return try JSONDecoder().decode([ProductEntity].self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }

    public func forceFetchExclusives() async throws -> [ProductEntity] {
        let data = try await networkClient.request(
            "main/exclusives",
            method: .post,
            options: .init(optional: [.tokenID])
        ).data

        do {
            return try JSONDecoder().decode([ProductEntity].self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }

    public func forceFetchHits() async throws -> [ProductEntity] {
        let data = try await networkClient.request(
            "main/hits",
            method: .post,
            options: .init(optional: [.tokenID])
        ).data

        do {
            return try JSONDecoder().decode([ProductEntity].self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }

    public func forceFetchNews() async throws -> [ProductEntity] {
        let data = try await networkClient.request(
            "main/news",
            method: .post,
            options: .init(optional: [.tokenID])
        ).data

        do {
            return try JSONDecoder().decode([ProductEntity].self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}

// MARK: - Constants

private extension TimeInterval {

    /// 5 минут
    static let cacheLifeTimeSeconds: Self = 5 * 60
}
