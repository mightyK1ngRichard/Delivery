//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import MainInterface
import CatalogInterface
import ProfileInterface
import BasketInterface
import Resolver
import DLNetwork
import UserServiceInterface
import OrderServiceInterface

enum RootAssembly {

    @MainActor
    static func assemble() -> some View {
        let state = RootScreenViewState()
        let networkStore = Resolver.resolve(AnyNetworkStore.self)

        let bootIteractor = BootIteractor(
            networkStore: networkStore,
            userService: Resolver.resolve(AnyUserService.self),
            orderService: Resolver.resolve(AnyOrderService.self)
        )
        let authSessionInteractor = AuthSessionInteractor(networkStore: networkStore)
        let viewModel = RootScreenViewModel(
            state: state,
            bootIteractor: bootIteractor,
            authSessionInteractor: authSessionInteractor
        )

        let mainCoordinator = Resolver.resolve(AnyMainAssembly.self).assemble(output: viewModel)
        let catalogCoordinator = Resolver.resolve(AnyCatalogAssembly.self).assemble(output: viewModel)
        let profileCoordinator = Resolver.resolve(AnyProfileAssembly.self).assemble(output: viewModel)
        let basketCoordinator = Resolver.resolve(AnyBasketAssembly.self).assemble(output: viewModel)

        return RootScreenView(
            state: state,
            mainCoordinator: mainCoordinator,
            catalogCoordinator: catalogCoordinator,
            profileCoordinator: profileCoordinator,
            basketCoordinator: basketCoordinator,
            output: viewModel
        )
    }
}
