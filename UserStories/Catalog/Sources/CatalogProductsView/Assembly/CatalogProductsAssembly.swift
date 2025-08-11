//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import Resolver
import SharedUserStories
import CatalogServiceInterface
import CartServiceInterface

@MainActor
enum CatalogProductsAssembly {

    static func assemble(
        category: CategoryModel,
        categories: [CategoryModel],
        output: CatalogProductsOutput
    ) -> some View {
        let priceFactory = PriceFactory()
        let dateFactory = DateFactory()
        let mediaFactory = MediaFactory()
        let productFactory = ProductFactory(
            priceFactory: priceFactory,
            dateFactory: dateFactory,
            mediaFactory: mediaFactory
        )

        let factory = CatalogProductsScreenFactory(productFactory: productFactory)
        let state = CatalogProductsState(
            factory: factory,
            category: category,
            tags: categories,
            navigationTitle: category.title
        )

        let networkClient = CatalogProductsScreenNetworkClient(
            catalogService: Resolver.resolve(AnyCategoryService.self),
            cartService: Resolver.resolve(AnyCartService.self)
        )
        let viewModel = CatalogProductsScreenViewModel(
            state: state,
            networkClient: networkClient,
            factory: factory,
            output: output
        )
        
        return CatalogProductsView(state: state, output: viewModel)
    }
}
