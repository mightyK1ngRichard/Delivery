//
//  Created by Dmitriy Permyakov on 06.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

public struct AddBasketProductPayload: Sendable {

    public let token: String
    public let addressID: Int
    public let productID: Int
    public let count: Int

    public init(
        token: String,
        addressID: Int,
        productID: Int,
        count: Int
    ) {
        self.token = token
        self.addressID = addressID
        self.productID = productID
        self.count = count
    }
}
