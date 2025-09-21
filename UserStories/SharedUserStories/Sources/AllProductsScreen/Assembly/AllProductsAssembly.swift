//
//  Created by Dmitriy Permyakov on 27.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import Resolver
import CartServiceInterface

public enum AllProductsScreenAssembly {

    @MainActor
    public static func assemble(
        products: [ProductModel],
        navigationTitle: String,
        output: AllProductsScreenOutput
    ) -> some View {
        let priceFactory = PriceFactory()
        let dateFactory = DateFactory()
        let mediaFactory = MediaFactory()
        let productFactory = ProductFactory(
            priceFactory: priceFactory,
            dateFactory: dateFactory,
            mediaFactory: mediaFactory
        )
        let factory = AllProductsScreenFactory(productFactory: productFactory)
        let state = AllProductsScreenViewState(
            products: products,
            navigationTitle: navigationTitle,
            factory: factory
        )

        let cartService = Resolver.resolve(AnyCartService.self)
        let networkClient = AllProductsNetworkClient(cartService: cartService)
        let viewModel = AllProductsScreenViewModel(
            state: state,
            cartService: cartService,
            networkClient: networkClient,
            output: output
        )

        return AllProductsScreenView(state: state, output: viewModel)
    }
}
