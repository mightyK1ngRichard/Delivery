//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories
import SharedContractsInterface
import DesignSystem

struct BasketScreenFactory: AnyBasketScreenFactory {

    let priceFactory: AnyPriceFactory
    let productFactory: AnyProductFactory

    func convertToProduct(from entity: ProductEntity) -> ProductModel? {
        productFactory.convertToProduct(from: entity)
    }

    func convertToProductHCard(from model: ProductModel) -> DLProductHCard.Configuration {
        .init(
            title: model.title,
            price: model.fullPrice.formattedPrice,
            unitPrice: model.itemPrice.formattedPrice.appending("/шт"),
            cornerPrice: model.cashback,
            startCount: model.magnifier,
            isLiked: false,
            imageKind: .url(model.imageURL),
            magnifier: model.magnifier
        )
    }

    func makePriceFormatting(for price: Double) -> String {
        priceFactory.convertToPrice(from: price) ?? String(price)
    }
}
