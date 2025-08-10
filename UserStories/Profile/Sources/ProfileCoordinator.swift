//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import SwiftUI
import DLCore
import Coordinator
import SharedUserStories
import ProfileInterface

final class ProfileCoordinator: Navigatable, AnyProfileCoordinator {

    let router: Router<ProfileRoute>
    let logger = DLLogger("Profile Coordinator")

    private var addressCoordinator: AddressCoordinator

    init(router: Router<ProfileRoute>) {
        self.router = router

        let proxyRouter = ProxyRouter<ProfileRoute, AddressRoute>(parentRouter: router)
        addressCoordinator = AddressAssembly.assemble(router: proxyRouter)
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
        case .userData:
            UserDataAssembly.assemble(output: self)
        case let .addressFlow(route):
            addressCoordinator.destination(route)
        }
    }
}

// MARK: - ProfileScreenOutput

extension ProfileCoordinator: ProfileScreenOutput {

    func openUserDataScreen() {
        logger.logEvent()
        router.push(.userData)
    }

    func openOrdersScreen() {
        logger.logEvent()
        router.push(.orders)
    }

    func openAddressesScreen() {
        logger.logEvent()
        router.push(.addressFlow(.addressesList))
    }

    func openProductDetails(product: ProductModel) {
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

// MARK: - UserDataScreenOutput

extension ProfileCoordinator: UserDataScreenOutput {
}
