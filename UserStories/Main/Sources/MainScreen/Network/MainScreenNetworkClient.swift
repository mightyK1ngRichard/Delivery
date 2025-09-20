//
//  Created by Dmitriy Permyakov on 07.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import SharedContractsInterface
import ProductServiceInterface
import BannerServiceInterface
import PopcatsServiceInterface
import UserServiceInterface
import CartServiceInterface
import SharedUserStories

protocol AnyMainScreenNetworkClient: Sendable {

    func fetchProducts() async throws -> [(ProductSection, [ProductEntity])]
    func fetchBanners() async throws -> [BannerEntity]
    func fetchPopCards() async throws -> [PopcatsEntity]
    func fetchProfile() async throws -> UserEntity
    func addProductInBasket(productID: Int, count: Int) async throws
    func updateProductCountInBasket(productID: Int, count: Int) async throws
}

struct MainScreenNetworkClient {

    let productService: AnyProductService
    let bannerService: AnyBannersService
    let popcatsService: AnyPopcatsService
    let userService: AnyUserService
    let cartService: AnyCartService
}

// MARK: - AnyMainScreenNetwork

extension MainScreenNetworkClient: AnyMainScreenNetworkClient {

    func fetchProducts() async throws -> [(ProductSection, [ProductEntity])] {
        async let stocks = productService.stocks
        async let exclusives = productService.exclusives
        async let hits = productService.hits
        async let news = productService.news

        let (
            stocksResult,
            exclusivesResult,
            hitsResult,
            newsResult
        ) = try await (stocks, exclusives, hits, news)

        return [
            (.actions, stocksResult),
            (.exclusives, exclusivesResult),
            (.hits, hitsResult),
            (.news, newsResult),
        ]
    }

    func fetchBanners() async throws -> [BannerEntity] {
        try await bannerService.banners
    }

    func fetchPopCards() async throws -> [PopcatsEntity] {
        try await popcatsService.popcats
    }

    func fetchProfile() async throws -> UserEntity {
        try await userService.forceFetchProfile()
    }

    func addProductInBasket(productID: Int, count: Int) async throws {
        try await cartService.addProductInBasket(body: .init(productID: productID, count: count))
    }

    func updateProductCountInBasket(productID: Int, count: Int) async throws {
        try await cartService.updateProductCountInBasket(productID: productID, count: count)
    }
}
