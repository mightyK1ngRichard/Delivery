//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

public struct ProductEntity: Decodable, Sendable {

    public let id: Int?
    let sku: String?
    public let title: String?
    let price: String?
    let quantity: Int?
    public let description: String?
    public let image: String?
    let categoryID: Int?
    let priceSale, cashback: String?
    let brandID, manufacturerID: Int?
    let createdAt, updatedAt, slug: String?
    public let actionFlag: Int?
    let actionCountdown: String?
    public let coeff: Int?
    let ean: String?
    public let hit, actionFlag2, exclusFlag, rating: Int?
    public let priceItem: String?
    public let tags: String?
    let maxInOrder: Int?
    let expirationDate: String?
    let kolvoUpak, newYearFlag, quantity2, countryID: Int?
    let brandTitle: String?
    let whishlistFlag: Bool?
    let realCount: Int?
    let brand: Brand?

    public init(
        id: Int?,
        sku: String?,
        title: String?,
        price: String?,
        quantity: Int?,
        description: String?,
        image: String?,
        categoryID: Int?,
        priceSale: String?,
        cashback: String?,
        brandID: Int?,
        manufacturerID: Int?,
        createdAt: String?,
        updatedAt: String?,
        slug: String?,
        actionFlag: Int?,
        actionCountdown: String?,
        coeff: Int?,
        ean: String?,
        hit: Int?,
        actionFlag2: Int?,
        exclusFlag: Int?,
        rating: Int?,
        priceItem: String?,
        tags: String?,
        maxInOrder: Int?,
        expirationDate: String?,
        kolvoUpak: Int?,
        newYearFlag: Int?,
        quantity2: Int?,
        countryID: Int?,
        brandTitle: String?,
        whishlistFlag: Bool?,
        realCount: Int?,
        brand: Brand?
    ) {
        self.id = id
        self.sku = sku
        self.title = title
        self.price = price
        self.quantity = quantity
        self.description = description
        self.image = image
        self.categoryID = categoryID
        self.priceSale = priceSale
        self.cashback = cashback
        self.brandID = brandID
        self.manufacturerID = manufacturerID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.slug = slug
        self.actionFlag = actionFlag
        self.actionCountdown = actionCountdown
        self.coeff = coeff
        self.ean = ean
        self.hit = hit
        self.actionFlag2 = actionFlag2
        self.exclusFlag = exclusFlag
        self.rating = rating
        self.priceItem = priceItem
        self.tags = tags
        self.maxInOrder = maxInOrder
        self.expirationDate = expirationDate
        self.kolvoUpak = kolvoUpak
        self.newYearFlag = newYearFlag
        self.quantity2 = quantity2
        self.countryID = countryID
        self.brandTitle = brandTitle
        self.whishlistFlag = whishlistFlag
        self.realCount = realCount
        self.brand = brand
    }
}

extension ProductEntity {

    enum CodingKeys: String, CodingKey {
        case id, sku, title, price, quantity, description, image
        case categoryID = "category_id"
        case priceSale = "price_sale"
        case cashback
        case brandID = "brand_id"
        case manufacturerID = "manufacturer_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case slug
        case actionFlag = "action_flag"
        case actionCountdown = "action_countdown"
        case coeff, ean, hit
        case actionFlag2 = "action_flag_2"
        case exclusFlag = "exclus_flag"
        case rating
        case priceItem = "price_item"
        case tags
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

extension ProductEntity {

    public struct Brand: Decodable, Sendable {

        let id: Int?
        let title: String?
        let createdAt, updatedAt: String?
        let mainFlag: Int?

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

extension ProductEntity.Brand {

    enum CodingKeys: String, CodingKey {
        case id, title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case mainFlag = "main_flag"
    }
}
