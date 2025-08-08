//
//  Created by Dmitriy Permyakov on 27.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import Resolver
import ProductServiceInterface
import BannerServiceInterface
import PopcatsServiceInterface
import UserServiceInterface
import CartServiceInterface

@MainActor
enum MainScreenAssembly {

    static func assemble(output: MainScreenOutput) -> some View {
        let priceFactory = PriceFactory()
        let dateFactory = DateFactory()
        let mediaFactory = MediaFactory()
        let productFactory = ProductFactory(
            priceFactory: priceFactory,
            dateFactory: dateFactory,
            mediaFactory: mediaFactory
        )
        let factory = MainScreenFactory(mediaFactory: mediaFactory, productFactory: productFactory)
        let state = MainScreenViewState(factory: factory)
        let networkClient = MainScreenNetworkClient(
            productService: Resolver.resolve(AnyProductService.self),
            bannerService: Resolver.resolve(AnyBannersService.self),
            popcatsService: Resolver.resolve(AnyPopcatsService.self),
            userService: Resolver.resolve(AnyUserService.self),
            cartService: Resolver.resolve(AnyCartService.self)
        )
        let viewModel = MainScreenViewModel(
            state: state,
            networkClient: networkClient,
            factory: factory,
            output: output
        )

        return MainScreenView(state: state, output: viewModel)
    }
}
