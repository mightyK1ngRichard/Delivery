//
//  Created by Dmitriy Permyakov on 29.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import Resolver
import SharedUserStories
import UserServiceInterface
import CartServiceInterface

@MainActor
enum BasketAssembly {

    static func assemble(output: BasketScreenOutput) -> some View {
        let priceFactory = PriceFactory()
        let dateFactory = DateFactory()
        let mediaFactory = MediaFactory()
        let productFactory = ProductFactory(
            priceFactory: priceFactory,
            dateFactory: dateFactory,
            mediaFactory: mediaFactory
        )
        let factory = BasketScreenFactory(priceFactory: priceFactory, productFactory: productFactory)
        let state = BasketViewState(factory: factory)

        let networkFactory = BasketNetworkClient(
            userService: Resolver.resolve(AnyUserService.self),
            cartService: Resolver.resolve(AnyCartService.self)
        )
        let viewModel = BasketViewModel(
            state: state,
            networkClient: networkFactory,
            factory: factory,
            output: output
        )

        return BasketScreenView(state: state, output: viewModel)
    }
}
