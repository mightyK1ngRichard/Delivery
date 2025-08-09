//
//  Created by Dmitriy Permyakov on 05.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import SwiftUI
import UserService
import DLCore
import DLNetwork
import SharedUserStories

final class ProfileViewModel {

    private let state: ProfileScreenViewState
    private let networkClient: AnyProfileScreenNetworkClient
    private weak var output: ProfileScreenOutput?

    private let logger = DLLogger("Profile View Model")

    @MainActor
    init(
        state: ProfileScreenViewState,
        networkClient: AnyProfileScreenNetworkClient,
        output: ProfileScreenOutput
    ) {
        self.state = state
        self.networkClient = networkClient
        self.output = output
    }
}

// MARK: - ProfileViewOuput

extension ProfileViewModel: ProfileScreenViewOuput {

    func onFirstAppear() {
        logger.logEvent()
        fetchData()
    }

    func onTapReloadData() {
        logger.logEvent()
        fetchData()
    }

    func onTapMenuCell(_ cell: ProfileScreenViewState.MenuCell) {
        logger.logEvent()

        switch cell {
        case .userData:
            output?.openUserDataScreen()
            break
        case .favorites:
            break
        case .address:
            output?.openAddressesScreen()
        case .orders:
            output?.openOrdersScreen()
        case .faq:
            break
        case .telegramBot:
            break
        case .info:
            break
        case .feedback:
            break
        case .quit:
            logout()
        }
    }

    func onTapRegistrationButton() {
        logger.logEvent()
        output?.openSignUpFlow()
    }

    func onTapSignInButton() {
        logger.logEvent()
        output?.openSignInFlow()
    }

    func onTapProduct(product: Product) {
        logger.logEvent()
        output?.openProductDetails(product: product)
    }
}

// MARK: - Helpers

private extension ProfileViewModel {

    @MainActor
    func fetchData() {
        state.screenKind = .screenState(.loading)

        Task {
            do {
                // TODO: Тут должно быть получение избранного и уведомлений
                let _ = try await networkClient.fetchUserData()

                state.notifications = [
                    .needAddress,
                    .needPhoneAndEmailConfirmation,
                ]
                state.screenKind = .screenState(.content)
            } catch {
                if let networkError = error as? NetworkClientError,
                   networkError == .clientError(.requiredFieldMissing(.tokenID)) {
                    logger.info("Включена авторизация")
                    state.screenKind = .needAuth
                } else {
                    logger.error(error)
                    state.screenKind = .screenState(.error)
                }
            }
        }
    }

    @MainActor
    func logout() {
        output?.logout()

        withAnimation {
            state.screenKind = .needAuth
        }
    }
}
