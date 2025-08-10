//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import SharedUserStories

@MainActor
final class CategoryListScreenViewState: ObservableObject {

    // MARK: Data
    @Published
    var categories: [CategoryModel] = []

    // MARK: UI
    @Published
    var state: ScreenState = .loading
    @Published
    var searchText = String()
    let navigationTitle: String

    init(navigationTitle: String) {
        self.navigationTitle = navigationTitle
    }

    var filteredCategoryCells: [CategoryModel] {
        guard !searchText.isEmpty else {
            return categories
        }

        return categories.filter { $0.title.contains(searchText) }
    }
}
