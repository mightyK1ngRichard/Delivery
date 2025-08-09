//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import SwiftUI
import DLCore
import Coordinator
import SharedUserStories

final class ProfileCoordinator: Navigatable {

    let router: Router<ProfileRoute>
    let logger = DLLogger("Profile Coordinator")

    init(router: Router<ProfileRoute>) {
        self.router = router
    }

    func run() -> some View {
        destination(.main)
    }

    @ViewBuilder
    func destination(_ route: ProfileRoute) -> some View {
        switch route {
        case .main:
            ProfileScreenAssembly.assemble(output: self)
        case .orders:
            OrdersScreenAssembly.assemble(output: self)
        }
    }
}

// MARK: - ProfileScreenOutput

extension ProfileCoordinator: ProfileScreenOutput {

    func openUserDataScreen() {
        logger.logEvent()
    }

    func openOrdersScreen() {
        logger.logEvent()
        router.push(.orders)
    }

    func openAddressesScreen() {
        logger.logEvent()
    }

    func openProductDetails(product: Product) {
        logger.logEvent()
    }

    func openSignInFlow() {
        logger.logEvent()
    }

    func openSignUpFlow() {
        logger.logEvent()
    }

    func showAlert(title: String, message: String) {
        logger.logEvent()
    }

    func logout() {
        logger.logEvent()
    }
}

// MARK: - OrdersScreenOutput

extension ProfileCoordinator: OrdersScreenOutput {

    func openOrderDetails(orderID: Int) {
        logger.logEvent()
    }
}
