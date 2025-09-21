//
//  Created by Dmitriy Permyakov on 27.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import SharedUserStories
import DLCore
import DesignSystem

extension CatalogProductsState {

    struct Item: Identifiable, Hashable {

        var id: Self { self }
        let sectionID: Int
        var product: ProductModel
    }
}

@MainActor
final class CatalogProductsState: Sendable, ObservableObject {

    let factory: AnyCatalogProductsScreenFactory

    @Published
    var tags: [CategoryModel]
    @Published
    var navigationTitle: String
    @Published
    var items: [Item] = []
    let category: CategoryModel

    // MARK: UI
    @Published
    var selectedTags: Set<CategoryModel> = []
    @Published
    var lastSelectedTag: CategoryModel?
    @Published
    var selectedProducts: Set<Int> = []
    @Published
    var searchText = String()
    @Published
    var screenState: ScreenState = .loading

    init(
        factory: AnyCatalogProductsScreenFactory,
        category: CategoryModel,
        tags: [CategoryModel],
        navigationTitle: String
    ) {
        self.factory = factory
        self.category = category
        self.tags = tags
        self.navigationTitle = navigationTitle
        self.selectedTags = [category]
        self.lastSelectedTag = category
    }

    func getTagCellBorderColor(for tag: CategoryModel) -> Color {
        selectedTags.contains(tag)
            ? DLColor<SeparatorPalette>.link.color
            : .clear
    }
}
