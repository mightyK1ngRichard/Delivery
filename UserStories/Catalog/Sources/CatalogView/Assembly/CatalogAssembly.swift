//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Resolver
import SharedUserStories
import ProductServiceInterface
import CatalogServiceInterface
import SwiftUI

enum CatalogAssembly {

    @MainActor
    static func assemble(output: CatalogScreenOutput) -> some View {
        let priceFactory = PriceFactory()
        let dateFactory = DateFactory()
        let mediaFactory = MediaFactory()
        let productFactory = ProductFactory(
            priceFactory: priceFactory,
            dateFactory: dateFactory,
            mediaFactory: mediaFactory
        )
        let categoryFactory = CategoryFactory(mediaFactory: mediaFactory)
        let factory = CatalogScreenFactory(
            productFactory: productFactory,
            categoryFactory: categoryFactory
        )

        let state = CatalogScreenViewState(factory: factory)
        let networkClient = CatalogScreenNetworkClient(
            catalogService: Resolver.resolve(AnyCategoryService.self),
            productService: Resolver.resolve(AnyProductService.self)
        )

        let viewModel = CatalogScreenViewModel(
            state: state,
            factory: factory,
            networkClient: networkClient,
            output: output
        )
        return CatalogScreenView(state: state, output: viewModel)
    }
}
