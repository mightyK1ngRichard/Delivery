//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI

final class ProductDetailsScreenViewState: ObservableObject {

    @Published
    var product: Product

    @Published
    var makeBasketButtonTitle: String?

    init(product: Product) {
        self.product = product
    }
}
