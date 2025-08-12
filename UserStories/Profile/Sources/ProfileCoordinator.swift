//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import Resolver
import SwiftUI
import DLCore
import Coordinator
import SharedUserStories
import ProfileInterface
import AuthInterface

final class ProfileCoordinator: Navigatable, AnyProfileCoordinator {

    let router: Router<ProfileRoute>
    let logger = DLLogger("Profile Coordinator")

    weak var profileInput: ProfileScreenInput?
    private weak var output: ProfileOutput?

    private let addressCoordinator: AddressCoordinator
    private var authCoordinator: (any AnyAuthCoordinator)?

    init(router: Router<ProfileRoute>, output: ProfileOutput) {
        self.router = router
        self.output = output

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
        case .authFlow:
            if let authCoordinator {
                NavigatableView(authCoordinator)
            }
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

        authCoordinator = Resolver
            .resolve(AnyAuthAssembly.self)
            .assemble(route: .signIn, output: self)

        router.fullScreenCover(.authFlow)
    }

    func openSignUpFlow() {
        logger.logEvent()
    }

    func showAlert(title: String, message: String) {
        logger.logEvent()
    }

    func logout() {
        logger.logEvent()
        output?.profileDidLogout()
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

// MARK: - AuthOutput

extension ProfileCoordinator: AuthOutput {

    func authCloseFlow() {
        logger.logEvent()
        router.dismiss()
    }

    func didLoginSuccess() {
        logger.logEvent()
        authCoordinator = nil

        Task {
            await output?.didLoginSuccess()
            profileInput?.didLoginSuccessfully()
            router.dismiss()
        }
    }
}
