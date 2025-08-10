//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories

public struct OrderModel: Hashable {

    public let totalAmount: PriceItem
    public let products: [ProductModel]
    /// Используемые бонусы кратные 100
    public var includedBonuses: Int
    public var paymentKind: PaymentKind
    /// Now + 1д
    public let deliveryDate: String
    public var deliveryPrice: Double

    /// Кэшбек после покупки
    public var receiveCashback: Double {
        products.reduce(into: 0.0) {
            $0 += $1.cashback * Double($1.count) * Double($1.magnifier)
        }
    }

    public init(
        totalAmount: PriceItem,
        products: [ProductModel],
        includedBonuses: Int,
        paymentKind: PaymentKind,
        deliveryDate: String,
        deliveryPrice: Double
    ) {
        self.totalAmount = totalAmount
        self.products = products
        self.includedBonuses = includedBonuses
        self.paymentKind = paymentKind
        self.deliveryDate = deliveryDate
        self.deliveryPrice = deliveryPrice
    }
}

// MARK: - PriceItem

extension OrderModel {

    public struct PriceItem: Hashable {

        public let price: Double
        public let formatedPrice: String

        public init(price: Double, formatedPrice: String) {
            self.price = price
            self.formatedPrice = formatedPrice
        }
    }

    public enum PaymentKind: Hashable {

        case cash
        case account
    }
}
