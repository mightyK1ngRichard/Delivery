//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol CatalogViewOutput {
    func onFirstAppear()
    func onTapReloadButton()
    func onTapCategory(categoryID: Int)
    func onTapLookAllProducts()
    func onTapLikeProduct(id: Int, isLike: Bool)
    func onTapBasketProduct(id: Int, counter: Int)
    func onTapProductCard(product: ProductModel)
}
