//
//  Created by Dmitriy Permyakov on 29.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import SharedUserStories

final class BasketViewState: ObservableObject {

    let factory: AnyBasketScreenFactory

    @Published
    var screenState: ScreenState = .loading
    @Published
    var products: [ProductModel] = []
    @Published
    var notifications: [OrderValidationNotifications] = []
    @Published
    var amountInfo = AmountInfo()
    @Published
    var isOpenedSheet = false

    init(factory: AnyBasketScreenFactory) {
        self.factory = factory
    }
}

// MARK: - TotalAmount

extension BasketViewState {

    struct AmountInfo: Hashable {

        var isReady = false
        var resultSumTitle = String()
        var needPriceTitle = String()
        var minPriceTitle = String()
    }
}

// MARK: - OrderValidationNotifications

enum OrderValidationNotifications: Identifiable, Hashable {

    case needAddress
    case needPhoneAndEmailConfirmation

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
