//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories

enum MainRoutes: Hashable, Identifiable {
    case main
    case product(ProductModel)
    case lookAll(navigationTitle: String, products: [ProductModel])
//    case pickAddress(token: String)
//    case addAddress(token: String)

    var id: Self { self }
}
