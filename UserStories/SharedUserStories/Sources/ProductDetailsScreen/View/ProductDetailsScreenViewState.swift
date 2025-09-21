//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DesignSystem

@MainActor
final class ProductDetailsScreenViewState: ObservableObject, Sendable {

    let product: ProductModel

    @Published
    var makeBasketButtonTitle: String?
    @Published
    var inBasket: Bool = false
    @Published
    var productCount: Int = 0
    @Published
    var showAlert = false
    var alertModel = AlertModel()

    init(product: ProductModel) {
        self.product = product
    }
}
