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
    func onTapProduct(productID: Int)
    func onTapOpenCatalog()
    func onTapMakeOrderButton()
    func onTapPlus(product: ProductModel, counter: Int)
    func onTapMinus(product: ProductModel, counter: Int)
    func onTapLike(productID: Int, isSelected: Bool)
    func onTapDelete(productID: Int)
}
