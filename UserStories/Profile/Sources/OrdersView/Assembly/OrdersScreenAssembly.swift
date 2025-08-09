//
//  Created by Dmitriy Permyakov on 29.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import SharedUserStories
import Resolver
import UserServiceInterface

enum OrdersScreenAssembly {

    @MainActor
    static func assemble(output: OrdersScreenOutput) -> some View {
        let priceFactory = PriceFactory()
        let factory = OrdersScreenFactory(priceFactory: priceFactory)
        let state = OrdersViewState(factory: factory)
        let networkClient = OrdersScreenNetworkClient(userService: Resolver.resolve(AnyUserService.self))
        let viewModel = OrdersScreenViewModel(
            state: state,
            factory: factory,
            networkClient: networkClient,
            output: output
        )

        return OrdersScreenView(state: state, output: viewModel)
    }
}
