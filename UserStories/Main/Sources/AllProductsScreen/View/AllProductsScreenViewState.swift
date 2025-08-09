//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import SharedUserStories

final class AllProductsScreenViewState: ObservableObject {

    let products: [Product]
    let navigationTitle: String
    let factory: AnyAllProductsScreenFactory

    init(
        products: [Product],
        navigationTitle: String,
        factory: AnyAllProductsScreenFactory
    ) {
        self.products = products
        self.navigationTitle = navigationTitle
        self.factory = factory
    }
}
