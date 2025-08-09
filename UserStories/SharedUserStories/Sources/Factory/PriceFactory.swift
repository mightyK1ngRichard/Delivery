//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation

public protocol AnyPriceFactory: Sendable {
    func convertToPrice(from priceItemString: String?) -> String?
}

public struct PriceFactory: AnyPriceFactory {

    private let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₽"
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()

    public init() {}

    /// Конвертируем из DTO в форматированную строку цены.
    public func convertToPrice(from priceItemString: String?) -> String? {
        guard let priceItemString,
              let priceItem = Double(priceItemString),
              let formattedString = priceFormatter.string(from: NSNumber(value: priceItem))
        else { return nil }

        return formattedString
    }
}
