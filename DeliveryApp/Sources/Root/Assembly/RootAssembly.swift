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

enum RootAssembly {

    @MainActor
    static func assemble() -> some View {
        let state = RootScreenViewState()
        let viewModel = RootScreenViewModel(state: state)
        let mainCoordinator = Resolver.resolve(AnyMainAssembly.self).assemble(output: viewModel)
        let catalogCoordinator = Resolver.resolve(AnyCatalogAssembly.self).assemble()
        let profileCoordinator = Resolver.resolve(AnyProfileAssembly.self).assemble()
        let basketCoordinator = Resolver.resolve(AnyBasketAssembly.self).assemble()

        return RootScreenView(
            state: state,
            mainCoordinator: mainCoordinator,
            catalogCoordinator: catalogCoordinator,
            profileCoordinator: profileCoordinator,
            basketCoordinator: basketCoordinator
        )
    }
}
