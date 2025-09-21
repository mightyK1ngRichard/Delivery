//
//  Created by Dmitriy Permyakov on 13.06.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DesignSystem

public struct ProductModel: Identifiable, Hashable, Sendable {
    
    /// Код продукта
    public let id: Int
    /// Фото
    public let imageURL: URL?
    /// Название продукта
    public var title: String
    /// Цена продукта за штуку
    public let itemPrice: Price
    /// Описание продукта
    public let description: String
    /// Теги продукта (Акция, новые и пр.)
    public let tags: [ProductSection]
    /// Брэнд продукта
    public let brand: Brand?
    /// Кэшбек за продукт
    public let cashback: Double
    /// Количество продукта  в упаковке с форматированным текстом: `10 шт.`
    public let packageCount: PackageCount
    /// Строка формата: 730 дней (до 14.08.28)
    public let formattedExpirationDate: String
    
    /// Настоящее количество продуктов (1шт, 2шт), без учёта `magnifier`
    public var count: Int
    /// Коэфициент увеличивания продукта (шаг)
    public let magnifier: Int
    /// Полная цену продукта: `Цена/шт × количество`
    public var fullPrice: Price
}

// MARK: - Brand, PackageCount, Price

extension ProductModel {
    
    /// Брэнд продукта
    public struct Brand: Identifiable, Hashable, Sendable {

        /// Код брэнда
        public let id: Int
        /// Название брэнда
        public let title: String
    }
    
    /// Количество штук продукта в упаковке
    public struct PackageCount: Hashable, Sendable {

        /// Число в упаковке
        public let count: Int
        /// Строка формата: `10 шт.`
        public let formattedCountTile: String
    }

    /// Отформатированная цена и значение
    public struct Price: Hashable, Sendable {

        /// Отформатированная цена за штуку в формате: `1029.60 ₽`
        public let formattedPrice: String
        /// Цена за штуку
        public let price: Double

        public init(formattedPrice: String, price: Double) {
            self.formattedPrice = formattedPrice
            self.price = price
        }
    }
}
