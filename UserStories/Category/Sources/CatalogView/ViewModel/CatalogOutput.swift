//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol CatalogOutput: AnyObject {
    func openCategoryList(category: CategoryModel)
    func openLookAllProducts(navigationTitle: String, products: [ProductModel])
    func openProductDetails(product: ProductModel)
}
