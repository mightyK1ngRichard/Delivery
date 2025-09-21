//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Combine
import Foundation
import MainInterface
import DLCore
import BasketInterface
import CatalogInterface
import ProfileInterface
import CartServiceInterface
import UserServiceInterface

final class RootScreenViewModel {

    private let state: RootScreenViewState
    private let bootIteractor: AnyBootIteractor
    private let authSessionInteractor: AnyAuthSessionInteractor
    private let cartService: AnyCartService
    private let userService: AnyUserService
    private let logger = DLLogger("Root Screen View Model")

    @MainActor
    private var cancellables: Set<AnyCancellable> = []

    @MainActor
    init(
        state: RootScreenViewState,
        bootIteractor: AnyBootIteractor,
        cartService: AnyCartService,
        userService: AnyUserService,
        authSessionInteractor: AnyAuthSessionInteractor
    ) {
        self.state = state
        self.bootIteractor = bootIteractor
        self.cartService = cartService
        self.authSessionInteractor = authSessionInteractor
        self.userService = userService

        cartService.basketProductsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                self?.state.basketBadge = products.count
            }
            .store(in: &cancellables)

        userService.userPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let user else { return }
                var count = 0
                if user.verifyFlagEmail == 1 {
                    count += 1
                }
                if user.verifyFlagPhone == 1 {
                    count += 1
                }

                self?.state.profileBadge = count
            }
            .store(in: &cancellables)
    }
}

// MARK: - RootScreenViewOutput

extension RootScreenViewModel: RootScreenViewOutput {

    func onFirstAppear() {
        logger.logEvent()

        Task {
            await startSession()
            state.screenState = .content
        }
    }
}

// MARK: - MainCoordinatorOutput

extension RootScreenViewModel: MainCoordinatorOutput {

    func openAuthScreen() {
        logger.logEvent()
    }
}

// MARK: - BasketOutput

extension RootScreenViewModel: BasketOutput {

    func basketDidOpenCatalog() {
        logger.logEvent()
        state.tabItem = .catalog
    }
}

// MARK: - CatalogOutput

extension RootScreenViewModel: CatalogOutput {
}

// MARK: - ProfileOutput

extension RootScreenViewModel: ProfileOutput {

    func didLoginSuccess() async {
        logger.logEvent()
        await startSession()
    }

    func profileDidLogout() {
        logger.logEvent()
        state.resetAll()

        Task {
            await authSessionInteractor.stopSession()
        }
    }
}

// MARK: - Helpers

extension RootScreenViewModel {

    @MainActor
    func startSession() async {
        let isAuth = await bootIteractor.initialize()
        guard isAuth else { return }

        // Получение стартовых данных
        let (_, products) = await bootIteractor.fetchInitialData()
        cartService.saveProductsBasket(products.compactMap {
            guard let id = $0.id, let count = $0.realCount else {
                return nil
            }
            return .init(id: id, count: count)
        })

        // Устанавливаем счётчик профиля, если нет адреса или нет верификации
//        var profileBadgeCount = 0
//        if await sessionStore.hasAddressDelivery {
//            profileBadgeCount += 1
//        }
//        let hasEmail = await sessionStore.userEmailIsCheched
//        let hasPhone = await sessionStore.userPhoneIsCheched
//        if hasEmail || hasPhone {
//            profileBadgeCount += 1
//        }

        state.showBasketFlow = true
        //state.basketBadge = products.count
//        state.profileBadge = profileBadgeCount
    }
}
