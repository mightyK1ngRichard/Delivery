//
//  Created by Dmitriy Permyakov on 27.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import SharedUserStories

public enum ProductDetailsAssembly {

    @MainActor
    public static func assemble(product: ProductModel, output: ProductDetailsScreenOutput) -> some View {
        let state = ProductDetailsScreenViewState(product: product)
        let factory = ProductDetailsScreenFactory()
        let viewModel = ProductDetailsScreenViewModel(
            state: state,
            factory: factory,
            output: output
        )
        return ProductDetailsView(state: state, output: viewModel)
    }
}
