//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import UserServiceInterface
import DesignSystem
import SharedUserStories

struct OrdersScreenFactory: AnyOrdersScreenFactory {

    let priceFactory: AnyPriceFactory

    func convertToOrder(from entity: OrderEntity) -> Order? {
        guard let id = entity.id,
              let price = priceFactory.convertToPrice(from: entity.totalPrice),
              let createdAt = entity.createdAt,
              let totalCashback = entity.totalCashback
        else { return nil }

        return Order(
            id: id,
            formattedTotalPrice: price,
            createdAt: createdAt,
            totalCashback: totalCashback,
            payment: "Оплата"
        )
    }

    func converToOrderCell(from model: Order) -> DLOrderInfoCell.Configuration {
        // FIXME: Поправить поля: creditedInfo, status, payment
        return .init(
            date: model.createdAt,
            price: model.formattedTotalPrice,
            cashback: model.totalCashback,
            creditedInfo: String(),
            status: .cancelled,
            payment: model.payment
        )
    }
}
