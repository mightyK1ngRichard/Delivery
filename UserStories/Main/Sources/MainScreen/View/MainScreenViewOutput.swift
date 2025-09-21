//
//  Created by Dmitriy Permyakov on 27.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol MainScreenViewOutput: AnyObject {

    func onFirstAppear()
    func onTapReload()
    func refresh() async
    func onTapSelectAddress()
    func onTapProductCard(product: ProductModel)
    func onTapSectionLookMore(section: ProductSection)
    func onTapPopcatsCell(id: Int, title: String)
    func onTapLike(id: Int, isLike: Bool)
    func onTapAddInBasket(product: ProductModel, section: ProductSection)
    func onTapPlus(product: ProductModel, section: ProductSection)
    func onTapMinus(product: ProductModel, section: ProductSection)
}
