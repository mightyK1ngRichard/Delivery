//
// Created by Dmitriy Permyakov on 06.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import DLNetwork
import CatalogServiceInterface

public struct CatalogServiceImpl {

    private let networkClient: AnyNetworkClient
    private let categoriesCacheStore = CacheStore<[CategoryEntity]>(cacheLifeTimeSeconds: 2.5 * 60)
    private let categoryProductsCacheStore = CacheStore<[Int: [CategoryProductEntity]]>(cacheLifeTimeSeconds: 2.5 * 60)

    private let logger = DLLogger("Catalog Service")

    public init(networkClient: AnyNetworkClient) {
        self.networkClient = networkClient
    }
}

// MARK: - AnyCategoryService

extension CatalogServiceImpl: AnyCategoryService {

    public func categories() async throws -> [CategoryEntity] {
        try await fetchFromStoreOrNetwork(storage: categoriesCacheStore) {
            try await forceFetchCategories()
        }
    }

    public func categoryProducts(categoryID: Int) async throws -> [CategoryProductEntity] {
        let (dict, shoudUpdate) = await categoryProductsCacheStore.value

        // Если не надо обновлять и данные есть
        if !shoudUpdate, let data = dict?[categoryID] {
            return data
        }

        return try await forceFetchCategoryProducts(categoryID: categoryID)
    }

    public func forceFetchCategoryProducts(categoryID: Int) async throws -> [CategoryProductEntity] {
        let data = try await networkClient.request(
            "catalog/products",
            method: .post,
            body: .basic(["category_id": categoryID])
        ).data

        do {
            return try JSONDecoder().decode(CategoryProductsResponse.self, from: data).products
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }

    public func forceFetchCategories() async throws -> [CategoryEntity] {
        let data = try await networkClient.request(
            "catalog/categories",
            method: .post,
            body: .basic()
        ).data

        do {
            return try JSONDecoder().decode([CategoryEntity].self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}

