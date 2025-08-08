//
//  Created by Dmitriy Permyakov on 27.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI

enum AllProductsScreenAssembly {

    @MainActor
    static func assemble(
        products: [Product],
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
        let viewModel = AllProductsScreenViewModel(
            state: state,
            output: output
        )

        return AllProductsScreenView(state: state, output: viewModel)
    }
}
