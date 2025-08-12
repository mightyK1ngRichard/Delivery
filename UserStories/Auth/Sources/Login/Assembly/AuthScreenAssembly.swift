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

    static func assemble(output: AuthScreenOutput) -> some View {
        let state = AuthScreenViewState()
        let neworkClient = AuthScreenNetworkClient(authService: Resolver.resolve(AnyAuthService.self))
        let viewModel = AuthScreenViewModel(
            state: state,
            neworkClient: neworkClient,
            output: output
        )

        return AuthScreenView(state: state, output: viewModel)
    }
}
