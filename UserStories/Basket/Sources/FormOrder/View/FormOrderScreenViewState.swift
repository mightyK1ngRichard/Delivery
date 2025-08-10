//
//  Created by Dmitriy Permyakov on 12.07.2025.
//  Copyright © 2025 Dostavka24 LLC. All rights reserved.
//

import Foundation
import SharedUserStories
import DesignSystem

@MainActor
final class FormOrderScreenViewState: ObservableObject {

    let factory: AnyFormOrderScreenFactory

    @Published
    var showSuccessView = false
    @Published
    var bonusesIncluded = false
    @Published
    var inputBonusesCount = String()
    @Published
    var deliveryDate = String()
    @Published
    var buttonState: ButtonState = .default
    @Published
    var resultSum: String

    let cashback: String?
    let deliveryPrice: String
    let products: [ProductModel]

    @Published
    var bonusesCount: Int?

    init(
        factory: AnyFormOrderScreenFactory,
        resultSum: String,
        cashback: String?,
        deliveryPrice: String,
        products: [ProductModel]
    ) {
        self.factory = factory
        self.cashback = cashback
        self.resultSum = resultSum
        self.deliveryPrice = deliveryPrice
        self.products = products
    }

    func convertToProductCarouselConfiguration() -> DLProductsCarousel.Configuration {
        factory.convertToProductCarouselConfiguration(products: products)
    }
}
