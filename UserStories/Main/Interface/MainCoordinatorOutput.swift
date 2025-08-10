//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

@MainActor
public protocol MainCoordinatorOutput: AnyObject, Sendable {
    func incrementCartCount()
    func decrementCartCount()

//    func addProductToBasket(product: ProductModel, count: Int)
//    func incrementProductCountInBasket(productID: Int, count: Int)
//    func decrementProductCountInBasket(productID: Int, count: Int)

    func openAuthScreen()
}
