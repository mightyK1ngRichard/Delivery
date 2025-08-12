//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories

public enum BasketRoute: Identifiable, Hashable {

    case main
    case makeOrder(orderModel: OrderModel)
    case productDetails(product: ProductModel)
    case paymentKindSheet(PaymentKind)

    public var id: Self { self }
}
