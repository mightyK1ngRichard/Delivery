//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories

enum CatalogRoute: Identifiable, Hashable {
    case main
    case categorySublist(category: CategoryModel)
    case categoryProducts(category: CategoryModel, categories: [CategoryModel])
    case productDetails(product: ProductModel)

    var id: Self { self }
}
