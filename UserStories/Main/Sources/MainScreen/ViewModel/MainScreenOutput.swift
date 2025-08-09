//
//  Created by Dmitriy Permyakov on 27.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol MainScreenOutput: AnyObject {
    func openProductDetatails(product: Product)
    func openAllProducts(sectionTitle: String, products: [Product])
    func openPopcats(id: Int, title: String)
    func openPickAddressScreen()
    func openAuthScreen()
    func showAlert(title: String, message: String)
    func showAuthAlert(title: String, message: String)
    func showAddAddressAlert(title: String, message: String, token: String)

    func incrementCartCount()
    func decrementCartCount()

    func addProductToBasket(product: Product, count: Int)
    func incrementProductCountInBasket(productID: Int, count: Int)
    func decrementProductCountInBasket(productID: Int, count: Int)
}
