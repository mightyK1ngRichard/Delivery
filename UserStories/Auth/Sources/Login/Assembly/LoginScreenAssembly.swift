//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import Resolver
import AuthServiceInterface
import AuthInterface

@MainActor
enum LoginScreenAssembly {

    static func assemble(output: LoginScreenOutput) -> some View {
        let state = LoginScreenViewState()
        let neworkClient = LoginScreenNetworkClient(authService: Resolver.resolve(AnyAuthService.self))
        let viewModel = LoginScreenViewModel(
            state: state,
            neworkClient: neworkClient,
            output: output
        )

        return LoginScreenView(state: state, output: viewModel)
    }
}
