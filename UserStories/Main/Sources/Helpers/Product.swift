//
//  Created by Dmitriy Permyakov on 13.06.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DesignSystem

struct Product: Identifiable, Hashable, Sendable {

    let id: Int
    let imageURL: String
    let title: String
    /// Цена в формате: 1029.60 руб
    let formattedPrice: String
    let description: String
    let startCounter: Int
    let magnifier: Int
    let tags: [ProductSection]
    let brand: Brand
    let cashback: String
    let packageCount: PackageCount
    /// Строка формата: 730 дней (до 14.08.28)
    let formattedExpirationDate: String
}

// MARK: - Brand

extension Product {

    struct Brand: Identifiable, Hashable {

        let id: Int
        let title: String
    }

    struct PackageCount: Hashable {
        
        /// Число
        let count: Int
        /// Строка формата: 10 шт.
        let formattedCountTile: String
    }
}
