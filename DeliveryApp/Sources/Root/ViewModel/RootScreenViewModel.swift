//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import MainInterface
import DLCore
import BasketInterface
import CatalogInterface

final class RootScreenViewModel {

    private let state: RootScreenViewState
    private let bootIteractor: AnyBootIteractor
    private let authSessionInteractor: AnyAuthSessionInteractor
    private let logger = DLLogger("Root Screen View Model")

    init(
        state: RootScreenViewState,
        bootIteractor: AnyBootIteractor,
        authSessionInteractor: AnyAuthSessionInteractor
    ) {
        self.state = state
        self.bootIteractor = bootIteractor
        self.authSessionInteractor = authSessionInteractor
    }
}

// MARK: - RootScreenViewOutput

extension RootScreenViewModel: RootScreenViewOutput {

    func onFirstAppear() {
        logger.logEvent()

        Task {
            let isAuth = await bootIteractor.initialize()
            let products = await bootIteractor.fetchInitialData()
            state.showBasketFlow = isAuth
            state.basketBadge = products.count
            state.screenState = .content
        }
    }
}

// MARK: - MainCoordinatorOutput

extension RootScreenViewModel: MainCoordinatorOutput {

    func incrementCartCount() {
        logger.logEvent()
        state.basketBadge += 1
    }

    func decrementCartCount() {
        logger.logEvent()
        state.basketBadge -= 1
    }

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

    func basketDidDecrementCartCount() {
        logger.logEvent()
        state.basketBadge -= 1
    }
}

// MARK: - CatalogOutput

extension RootScreenViewModel: CatalogOutput {

    func catalogDidIncrementCartCount() {
        logger.logEvent()
        state.basketBadge += 1
    }
}
