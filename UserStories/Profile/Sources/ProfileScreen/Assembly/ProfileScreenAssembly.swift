//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import Resolver
import UserServiceInterface

@MainActor
enum ProfileScreenAssembly {

    static func assemble(output: ProfileScreenOutput) -> some View {
        let state = ProfileScreenViewState()
        let networkClient = ProfileScreenNetworkClient(userService: Resolver.resolve(AnyUserService.self))
        let viewModel = ProfileViewModel(
            state: state,
            networkClient: networkClient,
            output: output
        )
        
        return ProfileScreenView(state: state, output: viewModel)
    }
}
