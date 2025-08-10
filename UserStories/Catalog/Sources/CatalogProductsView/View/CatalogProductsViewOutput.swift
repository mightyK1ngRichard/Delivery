//
//  Created by Dmitriy Permyakov on 27.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol CatalogProductsViewOutput {
    func onFirstAppear()
    func onSelectTag(tag: CategoryModel)
    func onTapSortButton()
    func onTapSliderButton()
    func onTapProductLike(productID: Int, isLike: Bool)
    func onTapProductPlus(productID: Int, counter: Int)
    func onTapProductMinus(productID: Int, counter: Int)
    func onTapProductBasket(productID: Int, counter: Int)
    func onTapProductCard(product: ProductModel)
}
