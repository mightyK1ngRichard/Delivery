//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

@MainActor
protocol AllProductsScreenViewOutput {

    func onFirstAppear()
    func onTapProductCard(for: ProductModel)
    func onTapProductLike(productID: Int, isLike: Bool)
    func onTapProductPlus(productID: Int)
    func onTapProductMinus(productID: Int)
    func onTapProductBasket(productID: Int)
}
