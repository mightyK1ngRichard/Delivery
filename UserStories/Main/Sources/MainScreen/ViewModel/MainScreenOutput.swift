//
//  Created by Dmitriy Permyakov on 27.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol MainScreenOutput: AnyObject {
    func mainScreenOpenProductDetatails(product: ProductModel)
    func mainScreenOpenAllProducts(sectionTitle: String, products: [ProductModel])
    func mainScreenOpenPopcats(id: Int, title: String)
    func mainScreenOpenPickAddressScreen()
    func mainScreenOpenAuthScreen()

    func mainScreenIncrementCartCount()
    func mainScreenDecrementCartCount()

    func mainScreenAddProductToBasket(product: ProductModel, count: Int)
    func mainScreenIncrementProductCountInBasket(productID: Int, count: Int)
    func mainScreenDecrementProductCountInBasket(productID: Int, count: Int)
}
