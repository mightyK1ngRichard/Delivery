//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

@MainActor
protocol AllProductsScreenViewOutput {
    func onFirstAppear()
    func onTapProductCard(for: Product)
    func onTapProductLike(productID: Int, isLike: Bool)
    func onTapProductPlus(productID: Int, counter: Int)
    func onTapProductMinus(productID: Int, counter: Int)
    func onTapProductBasket(productID: Int, counter: Int)
}
