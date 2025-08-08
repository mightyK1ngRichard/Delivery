//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI

public enum Tags: String {

    case promotion = "Акция"
    case hit = "Хит"
    case exclusive = "Экслюзив"
    case news = "Новинка"
}

extension Tags {

    public var backgroundColor: Color {
        switch self {
        case .promotion:
            return .purple
        case .hit:
            return .orange
        case .exclusive:
            return .green
        case .news:
            return .blue
        }
    }

    var icon: Image? {
        switch self {
        case .exclusive:
            return nil
        case .promotion:
            return DLIcon.discount.image
        case .hit:
            return DLIcon.hits.image
        case .news:
            return DLIcon.new.image
        }
    }
}
