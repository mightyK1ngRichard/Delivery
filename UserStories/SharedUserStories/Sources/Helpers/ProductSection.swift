//
//  Created by Dmitriy Permyakov on 13.06.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import SwiftUI

public enum ProductSection: Identifiable, Hashable, CaseIterable, Comparable, Sendable {

    /// Акции
    case actions
    /// Эксклюзив
    case exclusives
    /// Новое
    case news
    /// Хиты
    case hits
}

// MARK: - Calculated Values

extension ProductSection {

    public var id: Int {
        switch self {
        case .actions:
            return 3
        case .exclusives:
            return 2
        case .news:
            return 1
        case .hits:
            return 0
        }
    }

    public static let allCases: [ProductSection] = [
        .actions, .exclusives, .news, .hits
    ]

    public var title: String {
        switch self {
        case .actions:
            return String(localized: "stocks")
        case .exclusives:
            return String(localized: "exclusives")
        case .news:
            return String(localized: "news")
        case .hits:
            return String(localized: "hits")
        }
    }

    // FIXME: Вынести в ДС + Убрать дублирование кода
    public var backgroundColor: Color {
        switch self {
        case .actions:
            return .purple
        case .hits:
            return .orange
        case .exclusives:
            return .green
        case .news:
            return .blue
        }
    }

    public static func < (lhs: ProductSection, rhs: ProductSection) -> Bool {
        lhs.id < rhs.id
    }
}
