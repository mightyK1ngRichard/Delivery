//
//  Created by Dmitriy Permyakov on 12.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import SwiftUI
import DLCore
import Coordinator
import SharedUserStories
import AuthInterface

final class AuthCoordinator: Navigatable, AnyAuthCoordinator {

    let router: Router<AuthRoute>
    let startRoute: AuthRoute
    private weak var output: AuthOutput?
    let logger = DLLogger("Auth Coordinator")

    init(
        router: Router<AuthRoute>,
        startRoute: AuthRoute,
        output: AuthOutput
    ) {
        self.router = router
        self.startRoute = startRoute
        self.output = output
    }

    func run() -> some View {
        destination(startRoute)
    }

    @ViewBuilder
    func destination(_ route: AuthRoute) -> some View {
        switch route {
        case .signIn:
            LoginScreenAssembly.assemble(output: self)
        }
    }
}

// MARK: - LoginScreenOutput

extension AuthCoordinator: LoginScreenOutput {
    
    func authScreenDidSignInSuccess() {
        logger.logEvent()
        output?.didLoginSuccess()
    }

    func authScreenShowAlert(_: AlertModel) {
        logger.logEvent()
    }

    func authScreenDidClose() {
        logger.logEvent()
        output?.authCloseFlow()
    }
}
