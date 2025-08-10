//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import Resolver
import UserServiceInterface

@MainActor
enum UserDataAssembly {

    static func assemble(output: UserDataScreenOutput) -> some View {
        let state = UserDataViewState()
        let networkClient = UserDataScreenNetworkClient(userService: Resolver.resolve(AnyUserService.self))
        let factory = UserDataScreenFactory()
        let viewModel = UserDataScreenViewModel(
            state: state,
            networkClient: networkClient,
            factory: factory,
            output: output
        )
        return UserDataView(state: state, output: viewModel)
    }
}
