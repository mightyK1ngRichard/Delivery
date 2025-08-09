//
//  Created by Dmitriy Permyakov on 30.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol MainCoordinatorOutput: AnyObject {
    func incrementCartCount()
    func decrementCartCount()

    func addProductToBasket(product: Product, count: Int)
    func incrementProductCountInBasket(productID: Int, count: Int)
    func decrementProductCountInBasket(productID: Int, count: Int)

    func openAuthScreen()
}
