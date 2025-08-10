//
//  Created by Dmitriy Permyakov on 13.06.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DesignSystem

public struct ProductModel: Identifiable, Hashable, Sendable {

    public let id: Int
    public let imageURL: URL?
    public let title: String
    /// Цена в формате: 1029.60 руб
    public let formattedPrice: String
    public let description: String
    public let startCounter: Int
    public let magnifier: Int
    public let tags: [ProductSection]
    public let brand: Brand
    public let cashback: String
    public let packageCount: PackageCount
    /// Строка формата: 730 дней (до 14.08.28)
    public let formattedExpirationDate: String

    public init(
        id: Int,
        imageURL: URL?,
        title: String,
        formattedPrice: String,
        description: String,
        startCounter: Int,
        magnifier: Int,
        tags: [ProductSection],
        brand: Brand,
        cashback: String,
        packageCount: PackageCount,
        formattedExpirationDate: String
    ) {
        self.id = id
        self.imageURL = imageURL
        self.title = title
        self.formattedPrice = formattedPrice
        self.description = description
        self.startCounter = startCounter
        self.magnifier = magnifier
        self.tags = tags
        self.brand = brand
        self.cashback = cashback
        self.packageCount = packageCount
        self.formattedExpirationDate = formattedExpirationDate
    }
}

// MARK: - Brand

extension ProductModel {

    public struct Brand: Identifiable, Hashable, Sendable {

        public let id: Int
        public let title: String

        public init(id: Int, title: String) {
            self.id = id
            self.title = title
        }
    }

    public struct PackageCount: Hashable, Sendable {

        /// Число
        public let count: Int
        /// Строка формата: 10 шт.
        public let formattedCountTile: String

        public init(count: Int, formattedCountTile: String) {
            self.count = count
            self.formattedCountTile = formattedCountTile
        }
    }
}
