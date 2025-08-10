//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories
import DesignSystem

protocol AnyFormOrderScreenFactory {
    func convertToProductCarouselConfiguration(products: [ProductModel]) -> DLProductsCarousel.Configuration
    func makeFormattingPrice(for price: Double) -> String
}

struct FormOrderScreenFactory: AnyFormOrderScreenFactory {

    let priceFactory: AnyPriceFactory

    func convertToProductCarouselConfiguration(products: [ProductModel]) -> DLProductsCarousel.Configuration {
        .init(
            title: "\(products.count) товаров",
            items: products.compactMap(convertToProductsCarouselItem)
        )
    }

    func makeFormattingPrice(for price: Double) -> String {
        priceFactory.convertToPrice(from: price) ?? String(price)
    }

    private func convertToProductsCarouselItem(from model: ProductModel) -> DLProductsCarousel.Item? {
        guard let url = model.imageURL else { return nil }
        return .init(id: model.id, url: url)
    }
}
