//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

enum OrderValidationNotifications: Identifiable, Hashable {

    case needAddress
    case needPhoneAndEmailConfirmation
}

extension OrderValidationNotifications {

    var id: Self { self }

    var title: String {
        switch self {
        case .needAddress:
            "Вы должны добавить хотя бы один адрес доставки для оформления заказа."
        case .needPhoneAndEmailConfirmation:
            "Для оформления заказа вы должны подтвердить Email и телефон в «Личном кабинете»"
        }
    }
}
