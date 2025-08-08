//
//  Created by Dmitriy Permyakov on 13.06.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import SwiftUI

enum ProductSection: Identifiable, Hashable, CaseIterable {

    case actions
    case exclusives
    case news
    case hits
}

// MARK: - Calculated Values

extension ProductSection {

    var id: Int {
        switch self {
        case .actions:
            return 0
        case .exclusives:
            return 1
        case .news:
            return 2
        case .hits:
            return 3
        }
    }

    static var allCases: [ProductSection] = [
        .actions, .exclusives, .news, .hits
    ]

    var title: String {
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
    var backgroundColor: Color {
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
}
