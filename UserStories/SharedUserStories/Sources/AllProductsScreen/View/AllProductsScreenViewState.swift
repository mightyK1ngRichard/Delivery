//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation

@MainActor
final class AllProductsScreenViewState: Sendable, ObservableObject {

    @Published
    var products: [ProductModel]
    @Published
    var selectedProducts: Set<Int> = []

    let navigationTitle: String
    let factory: AnyAllProductsScreenFactory

    init(
        products: [ProductModel],
        navigationTitle: String,
        factory: AnyAllProductsScreenFactory
    ) {
        self.products = products
        self.navigationTitle = navigationTitle
        self.factory = factory
    }
}
