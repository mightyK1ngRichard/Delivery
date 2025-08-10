//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import SharedUserStories
import CatalogServiceInterface
import Resolver

enum CategoryListAssembly {

    @MainActor
    static func assemble(category: CategoryModel, output: CategoryListScreenOutput) -> some View {
        let state = CategoryListScreenViewState(navigationTitle: category.title)

        let mediaFactory = MediaFactory()
        let categoryFactory = CategoryFactory(mediaFactory: mediaFactory)
        let factory = CategoryListFactory(categoryFactory: categoryFactory)

        let networkClient = CategoryListNetworkClient(categoryService: Resolver.resolve(AnyCategoryService.self))

        let viewModel = CategoryListScreenViewModel(
            state: state,
            parentCategoryID: category.id,
            factory: factory,
            networkClient: networkClient,
            output: output
        )
        return CategoryListScreenView(state: state, output: viewModel)
    }
}
