//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import SharedUserStories

final class ProfileScreenViewState: ObservableObject {

    @Published
    var screenKind: ProfileScreenKind = .screenState(.loading)

    @Published
    var favoriteProducts: [Product] = []

    @Published
    var notifications: [OrderValidationNotifications] = []

    let menuCells: [MenuCell] = MenuCell.allCases
}

// MARK: - ProfileScreenState

extension ProfileScreenViewState {

    enum ProfileScreenKind: Hashable {
        case needAuth
        case screenState(ScreenState)
    }
}

// MARK: - MenuCells

extension ProfileScreenViewState {

    enum MenuCell: String, CaseIterable, Identifiable, Hashable {
        case userData
        case favorites
        case address
        case orders
        case faq
        case telegramBot
        case info
        case feedback
        case quit
    }
}

extension ProfileScreenViewState.MenuCell {

    var id: String { locolizedString }

    var locolizedString: String {
        switch self {
        case .userData:
            return String(localized: "данные пользователя")
        case .favorites:
            return String(localized: "избранное")
        case .address:
            return String(localized: "адреса доставки")
        case .orders:
            return String(localized: "заказы")
        case .faq:
            return String(localized: "FAQ")
        case .telegramBot:
            return String(localized: "Telegram Bot")
        case .info:
            return String(localized: "О компании")
        case .feedback:
            return String(localized: "Связаться с нами")
        case .quit:
            return String(localized: "Выйти")
        }
    }

    var iconRosource: String {
        switch self {
        case .userData:
            return "profile"
        case .favorites:
            return "favorite"
        case .address:
            return "map"
        case .orders:
            return "car"
        case .faq:
            return "faq"
        case .telegramBot:
            return "telegramBot"
        case .info:
            return "info"
        case .feedback:
            return "feedback"
        case .quit:
            return "quit"
        }
    }
}
