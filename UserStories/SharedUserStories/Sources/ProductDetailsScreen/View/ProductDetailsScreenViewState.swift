//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DesignSystem

final class ProductDetailsScreenViewState: ObservableObject {

    let product: ProductModel

    @Published
    var makeBasketButtonTitle: String?
    @Published
    var basketButtonIsPressed: Bool = false
    @Published
    var productCount: Int = 0
    @Published
    var showAlert = false
    var alertModel = AlertModel()

    init(product: ProductModel) {
        self.product = product
    }
}
