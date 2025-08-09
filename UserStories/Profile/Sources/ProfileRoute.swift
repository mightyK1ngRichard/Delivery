//
//  Created by Dmitriy Permyakov on 30.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

enum ProfileRoute: Hashable, Identifiable {
    case main
//    case signIn
//    case signUp
//    case userData
//    case addresses
//    case productDetails(Product)
//    case orderDetails(orderID: Int)
    case orders
//    case addAddress

    var id: Self { self }
}
