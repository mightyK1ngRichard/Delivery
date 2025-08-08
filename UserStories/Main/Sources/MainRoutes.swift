//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

enum MainRoutes: Hashable, Identifiable, Sendable {
    case main
    case product(Product)
//    case lookAll(sectionTitle: String, products: [ProductEntity])
//    case pickAddress(token: String)
//    case addAddress(token: String)

    var id: Self { self }
}
