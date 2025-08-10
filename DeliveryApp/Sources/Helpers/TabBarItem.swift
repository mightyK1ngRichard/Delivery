//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import DesignSystem
import SwiftUI

enum TabBarItem: String, CaseIterable {

    case house
    case catalog
    case cart
    case profile
}

extension TabBarItem {

    var locolized: String {
        switch self {
        case .house:
            "Главная"
        case .catalog:
            "Каталог"
        case .cart:
            "Корзина"
        case .profile:
            "Профиль"
        }
    }

    var image: Image {
        let image = switch self {
        case .house:
            DLIcon.home
        case .catalog:
            DLIcon.magnifier
        case .cart:
            DLIcon.cart
        case .profile:
            DLIcon.profileBar
        }
        return image.image
            .renderingMode(.template)
    }
}
