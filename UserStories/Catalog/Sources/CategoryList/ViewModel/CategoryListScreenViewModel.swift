//
//  Created by Dmitriy Permyakov on 26.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import SharedUserStories
import DLCore

final class CategoryListScreenViewModel {

    private let state: CategoryListScreenViewState
    private let parentCategoryID: Int
    private let factory: AnyCategoryListFactory
    private let networkClient: AnyCategoryListNetworkClient
    private weak var output: CategoryListScreenOutput?

    private let logger = DLLogger("Category List View Model")

    init(
        state: CategoryListScreenViewState,
        parentCategoryID: Int,
        factory: AnyCategoryListFactory,
        networkClient: AnyCategoryListNetworkClient,
        output: CategoryListScreenOutput
    ) {
        self.state = state
        self.parentCategoryID = parentCategoryID
        self.factory = factory
        self.networkClient = networkClient
        self.output = output
    }
}

// MARK: - CategoryListViewOuput

extension CategoryListScreenViewModel: CategoryListScreenViewOuput {

    func onFirstAppear() {
        logger.logEvent()
        fetchSubcategories()
    }

    func onTapReloadButton() {
        logger.logEvent()
        fetchSubcategories()
    }

    func onTapCategoryCell(category: CategoryModel) {
        logger.logEvent()
        output?.categoryListDidOpenCategoryProductsScreen(category: category, categories: state.categories)
    }
}

// MARK: - Helpers

private extension CategoryListScreenViewModel {

    @MainActor
    func fetchSubcategories() {
        state.state = .loading

        Task {
            do {
                let categories = try await networkClient.fetchCategories()
                let mapped = categories
                    .filter { $0.parentID == parentCategoryID }
                    .compactMap(factory.convertToCategory)

                state.categories = mapped
                state.state = .content
            } catch {
                logger.error(error)
                output?.categoryListDidShowAlert(message: error.localizedDescription)
                state.state = .error
            }
        }
    }
}
