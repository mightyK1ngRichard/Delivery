//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories

struct OrderModel: Hashable {

    let totalAmount: PriceItem
    let products: [ProductModel]
    /// Используемые бонусы кратные 100
    var includedBonuses: Int
    var paymentKind: PaymentKind
    /// Now + 1д
    let deliveryDate: String
    var deliveryPrice: Double

    /// Кэшбек после покупки
    var receiveCashback: Double {
        products.reduce(into: 0.0) {
            $0 += $1.cashback * Double($1.count) * Double($1.magnifier)
        }
    }
}

// MARK: - PriceItem

extension OrderModel {

    struct PriceItem: Hashable {

        let price: Double
        let formatedPrice: String
    }

    enum PaymentKind: Hashable {

        case cash
        case account
    }
}
