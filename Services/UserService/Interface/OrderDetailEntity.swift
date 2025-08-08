//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

public struct OrderDetailEntity: Decodable, Sendable {

    let id: Int?
    let email, phone, name: String?
    let userID: Int?
    let totalPrice: String?
    let status: Int?
    let createdAt, updatedAt, address, totalCashback: String?
    let chargeFlag: Int?
    let bonus, shippingCost: String?
    let sendFlag, changedFlag, paymentType: Int?
    let comment: String?
    let deliveryDate: String?
    let stockID, courierID: Int?
    let orderProducts: [OrderProduct]?

    public init(
        id: Int?,
        email: String?,
        phone: String?,
        name: String?,
        userID: Int?,
        totalPrice: String?,
        status: Int?,
        createdAt: String?,
        updatedAt: String?,
        address: String?,
        totalCashback: String?,
        chargeFlag: Int?,
        bonus: String?,
        shippingCost: String?,
        sendFlag: Int?,
        changedFlag: Int?,
        paymentType: Int?,
        comment: String?,
        deliveryDate: String?,
        stockID: Int?,
        courierID: Int?,
        orderProducts: [OrderProduct]?
    ) {
        self.id = id
        self.email = email
        self.phone = phone
        self.name = name
        self.userID = userID
        self.totalPrice = totalPrice
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.address = address
        self.totalCashback = totalCashback
        self.chargeFlag = chargeFlag
        self.bonus = bonus
        self.shippingCost = shippingCost
        self.sendFlag = sendFlag
        self.changedFlag = changedFlag
        self.paymentType = paymentType
        self.comment = comment
        self.deliveryDate = deliveryDate
        self.stockID = stockID
        self.courierID = courierID
        self.orderProducts = orderProducts
    }
}

extension OrderDetailEntity {

    enum CodingKeys: String, CodingKey {
        case id, email, phone, name
        case userID = "user_id"
        case totalPrice = "total_price"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case address
        case totalCashback = "total_cashback"
        case chargeFlag = "charge_flag"
        case bonus
        case shippingCost = "shipping_cost"
        case sendFlag = "send_flag"
        case changedFlag = "changed_flag"
        case paymentType = "payment_type"
        case comment
        case deliveryDate = "delivery_date"
        case stockID = "stock_id"
        case courierID = "courier_id"
        case orderProducts = "order_proudcts"
    }
}

// MARK: - OrderProudct

extension OrderDetailEntity {

    public struct OrderProduct: Decodable, Sendable {

        let id: Int?
        let sku, title, price: String?
        let quantity: Int?
        let description, image: String?
        let categoryID: Int?
        let priceSale, cashback: String?
        let brandID, manufacturerID: Int?
        let createdAt, updatedAt, slug: String?
        let actionFlag: Int?
        let actionCountdown: String?
        let coeff: Int?
        let ean: String?
        let hit, actionFlag2, exclusFlag, rating: Int?
        let priceItem: String?
        let maxInOrder: Int?
        let expirationDate: String?
        let kolvoUpak, newYearFlag, quantity2, countryID: Int?
        let orderCount: Int?
        let brandTitle: String?

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
            maxInOrder: Int?,
            expirationDate: String?,
            kolvoUpak: Int?,
            newYearFlag: Int?,
            quantity2: Int?,
            countryID: Int?,
            orderCount: Int?,
            brandTitle: String?
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
            self.maxInOrder = maxInOrder
            self.expirationDate = expirationDate
            self.kolvoUpak = kolvoUpak
            self.newYearFlag = newYearFlag
            self.quantity2 = quantity2
            self.countryID = countryID
            self.orderCount = orderCount
            self.brandTitle = brandTitle
        }
    }
}

extension OrderDetailEntity.OrderProduct {

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
        case maxInOrder = "max_in_order"
        case expirationDate = "expiration_date"
        case kolvoUpak = "kolvo_upak"
        case newYearFlag = "new_year_flag"
        case quantity2 = "quantity_2"
        case countryID = "country_id"
        case orderCount = "order_count"
        case brandTitle = "brand_title"
    }
}
