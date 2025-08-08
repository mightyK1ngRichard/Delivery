//
//  Created by Dmitriy Permyakov on 27.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

@MainActor
protocol MainScreenViewOutput: AnyObject {
    func onFirstAppear()
    func onTapReload()
    func onTapSelectAddress()
    func onTapProductCard(product: Product)
    func onTapSectionLookMore(section: ProductSection)
    func onTapPopcatsCell(id: Int, title: String)
    func onTapLike(id: Int, isLike: Bool)
    func onTapAddInBasket(id: Int, counter: Int, coeff: Int, section: ProductSection)
    func onTapPlusInBasket(productID: Int, counter: Int, coeff: Int, section: ProductSection)
    func onTapMinusInBasket(productID: Int, counter: Int, coeff: Int, section: ProductSection)
}
