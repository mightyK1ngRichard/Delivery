//
// Created by Dmitriy Permyakov on 06.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

public struct OrderPayload: Sendable {

    public let bonus: Int
    public let products: [OrderProduct]

    public init(bonus: Int, products: [OrderProduct]) {
        self.bonus = bonus
        self.products = products
    }
}

// MARK: - OrderProduct

extension OrderPayload {

    public struct OrderProduct: Sendable {

        public let id: String
        public let count: Int

        public init(id: String, count: Int) {
            self.id = id
            self.count = count
        }
    }
}
