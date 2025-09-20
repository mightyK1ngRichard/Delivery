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
    func onTapAddInBasket(product: ProductModel, counter: Int, coeff: Int, section: ProductSection)
    func onTapPlusInBasket(product: ProductModel, counter: Int, coeff: Int, section: ProductSection)
    func onTapMinusInBasket(product: ProductModel, counter: Int, coeff: Int, section: ProductSection)
}
