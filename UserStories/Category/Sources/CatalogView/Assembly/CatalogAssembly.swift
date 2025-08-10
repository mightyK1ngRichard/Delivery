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
    static func assemble(output: CatalogOutput) -> some View {
        let priceFactory = PriceFactory()
        let dateFactory = DateFactory()
        let mediaFactory = MediaFactory()
        let productFactory = ProductFactory(
            priceFactory: priceFactory,
            dateFactory: dateFactory,
            mediaFactory: mediaFactory
        )
        let factory = CatalogScreenFactory(
            productFactory: productFactory,
            mediaFactory: mediaFactory
        )

        let state = CatalogViewState(factory: factory)
        let networkClient = CatalogScreenNetworkClient(
            catalogService: Resolver.resolve(AnyCategoryService.self),
            productService: Resolver.resolve(AnyProductService.self)
        )

        let viewModel = CatalogViewModel(
            state: state,
            factory: factory,
            networkClient: networkClient,
            output: output
        )
        return CatalogView(state: state, output: viewModel)
    }
}
