//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol CatalogScreenOutput: AnyObject {
    func catalogScreenDidOpenCategoryList(category: CategoryModel)
    func catalogScreenDidOpenLookAllProducts(navigationTitle: String, products: [ProductModel])
    func catalogScreenDidOpenProductDetails(product: ProductModel)
}
