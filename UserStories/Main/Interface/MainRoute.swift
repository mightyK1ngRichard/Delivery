//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories

public enum MainRoute: Hashable, Identifiable {
    case main
    case product(ProductModel)
    case lookAll(navigationTitle: String, products: [ProductModel])

    public var id: Self { self }
}
