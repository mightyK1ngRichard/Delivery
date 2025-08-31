//
//  Created by Dmitriy Permyakov on 24.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

/// Продукт в корзине
public struct BasketProduct: Sendable {

    public let id: Int
    public let count: Int

    public init(id: Int, count: Int) {
        self.id = id
        self.count = count
    }
}
