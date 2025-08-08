//
//  Created by Dmitriy Permyakov on 06.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

public struct AddBasketProductPayload: Sendable {

    public let productID: Int
    public let count: Int

    public init(productID: Int, count: Int) {
        self.productID = productID
        self.count = count
    }
}
