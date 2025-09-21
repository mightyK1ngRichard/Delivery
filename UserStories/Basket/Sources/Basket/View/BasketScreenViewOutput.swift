//
//  Created by Dmitriy Permyakov on 29.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol BasketScreenViewOutput {
    func onFirstAppear()
    func onAppear()
    func onTapReloadButton()
    func onTapProduct(product: ProductModel)
    func onTapOpenCatalog()
    func onTapMakeOrderButton()
    func onTapPlus(product: ProductModel)
    func onTapMinus(product: ProductModel)
    func onTapLike(productID: Int, isSelected: Bool)
    func onTapDelete(productID: Int)
}
