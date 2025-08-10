//
//  Created by Dmitriy Permyakov on 29.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol BasketScreenOutput: AnyObject {
    func basketScreenDidOpenProductDetails(product: ProductModel)
    func basketScreenDidOpenCatalog()
    func basketScreenDidOpenMakeOrderScreen(orderModel: OrderModel)
    func basketScreenDidShowAlert(with alert: AlertModel)
}
