//
// Created by Dmitriy Permyakov on 06.08.2025.
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation

public struct CategoryProductsResponse: Decodable, Sendable {

    public let products: [CategoryProductEntity]

    public init(products: [CategoryProductEntity]) {
        self.products = products
    }
}

// MARK: - CategoryProductEntity

public struct CategoryProductEntity: Decodable, Sendable, Identifiable, Hashable {

    public let id: Int?
    public let sku: String?
    public let title: String?
    public let price: String?
    public let quantity: Int?
    public let description: String?
    public let image: String?
    public let categoryID: Int?
    public let priceSale: String?
    public let cashback: Double?
    public let brandID: Int?
    public let manufacturerID: Int?
    public let createdAt: String?
    public let updatedAt: String?
    public let slug: String?
    public let actionFlag: Int?
    public let coeff: Int?
    public let ean: String?
    public let hit: Int?
    public let actionFlag2: Int?
    public let exclusFlag: Int?
    public let rating: Int?
    public let priceItem: String?
    public let maxInOrder: Int?
    public let expirationDate: String?
    public let kolvoUpak: Int?
    public let newYearFlag: Int?
    public let quantity2: Int?
    public let countryID: Int?
    public let brandTitle: String?
    public let whishlistFlag: Bool?
    public let realCount: Int?
    public let brand: Brand
}

extension CategoryProductEntity {

    enum CodingKeys: String, CodingKey {
        case id
        case sku
        case title
        case price
        case quantity
        case description
        case image
        case categoryID = "category_id"
        case priceSale = "price_sale"
        case cashback
        case brandID = "brand_id"
        case manufacturerID = "manufacturer_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case slug
        case actionFlag = "action_flag"
        case coeff
        case ean
        case hit
        case actionFlag2 = "action_flag_2"
        case exclusFlag = "exclus_flag"
        case rating
        case priceItem = "price_item"
        case maxInOrder = "max_in_order"
        case expirationDate = "expiration_date"
        case kolvoUpak = "kolvo_upak"
        case newYearFlag = "new_year_flag"
        case quantity2 = "quantity_2"
        case countryID = "country_id"
        case brandTitle = "brand_title"
        case whishlistFlag = "whishlist_flag"
        case realCount = "realCount"
        case brand
    }
}

// MARK: - Brand

extension CategoryProductEntity {

    public struct Brand: Decodable, Sendable, Hashable {

        public let id: Int?
        public let title: String?
        public let createdAt, updatedAt: String?
        public let mainFlag: Int?

        public init(
            id: Int?,
            title: String?,
            createdAt: String?,
            updatedAt: String?,
            mainFlag: Int?
        ) {
            self.id = id
            self.title = title
            self.createdAt = createdAt
            self.updatedAt = updatedAt
            self.mainFlag = mainFlag
        }
    }
}

extension CategoryProductEntity.Brand {

    enum CodingKeys: String, CodingKey {
        case id, title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case mainFlag = "main_flag"
    }
}
