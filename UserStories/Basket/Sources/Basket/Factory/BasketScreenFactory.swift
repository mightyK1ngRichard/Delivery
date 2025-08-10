//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories
import SharedContractsInterface
import DesignSystem
import Foundation

struct BasketScreenFactory: AnyBasketScreenFactory {

    let priceFactory: AnyPriceFactory
    let productFactory: AnyProductFactory

    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()

    func convertToProduct(from entity: ProductEntity) -> ProductModel? {
        productFactory.convertToProduct(from: entity)
    }

    func convertToProductHCard(from model: ProductModel) -> DLProductHCard.Configuration {
        .init(
            title: model.title,
            price: model.fullPrice.formattedPrice,
            unitPrice: model.itemPrice.formattedPrice.appending("/шт"),
            cornerPrice: String(model.cashback),
            startCount: model.count * model.magnifier,
            isLiked: false,
            imageKind: .url(model.imageURL),
            magnifier: model.magnifier
        )
    }

    func makePriceFormatting(for price: Double) -> String {
        priceFactory.convertToPrice(from: price) ?? String(price)
    }

    func deliveryDateTitle() -> String {
        let now = Date.now

        // Получаем завтра и послезавтра
        guard let tomorrow = calendar.date(byAdding: .day, value: 1, to: now),
              let dayAfterTomorrow = calendar.date(byAdding: .day, value: 2, to: now) else {
            return "Доставка —"
        }

        // Если месяц один и тот же (например, 4–5 июля)
        if calendar.isDate(tomorrow, equalTo: dayAfterTomorrow, toGranularity: .month) {
            // Только день
            dateFormatter.dateFormat = "d"
            let day1 = dateFormatter.string(from: tomorrow)
            let day2 = dateFormatter.string(from: dayAfterTomorrow)

            // Полное название месяца
            dateFormatter.dateFormat = "MMMM"
            let month = dateFormatter.string(from: tomorrow)

            return "Доставка \(day1) – \(day2) \(month)"
        } else {
            // Если даты в разных месяцах
            dateFormatter.dateFormat = "d MMMM"
            let date1 = dateFormatter.string(from: tomorrow)
            let date2 = dateFormatter.string(from: dayAfterTomorrow)

            return "Доставка \(date1) – \(date2)"
        }
    }
}
