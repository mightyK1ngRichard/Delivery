//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import SharedUserStories
import DLCore

@MainActor
final class CatalogScreenViewState: Sendable, ObservableObject {

    let factory: AnyCatalogScreenFactory

    // MARK: Data

    /// Популярные категории (9шт.)
    @Published
    var categories: [SharedUserStories.CategoryModel] = []
    /// Популярные продукты (Хиты)
    @Published
    var products: [ProductModel] = []
    @Published
    var selectedProducts: Set<Int> = []

    var filterProducts: [ProductModel] {
        guard !searchText.isEmpty else {
            return products
        }

        return products.filter { $0.title.contains(searchText) }
    }

    // MARK: UI

    @Published
    var screenState: ScreenState = .loading
    @Published
    var searchText = String()
    var isLoading: Bool {
        screenState == .loading
    }

    init(factory: AnyCatalogScreenFactory) {
        self.factory = factory
    }
}
