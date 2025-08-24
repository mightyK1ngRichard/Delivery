//
//  Created by Dmitriy Permyakov on 27.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import DesignSystem
import DLCore
import SharedUserStories

@MainActor
final class MainScreenViewState: ObservableObject {

    let factory: MainScreenFactory

    // MARK: Data
    let tags: [DTagsSection.Section]
    @Published
    var sections: [(section: ProductSection, products: [ProductModel])] = []
    @Published
    var banners: [BannerPage] = []
    @Published
    var popcats: [PopcatModel] = []
    @Published
    var lastSelectedSection: String?

    // MARK: UI
    @Published
    var searchText = String()
    @Published
    var screenState = ScreenState.loading
    @Published
    var showAddressView = false
    @Published
    var balance: String?
    @Published
    var addressTitle: String?
    @Published
    var showAlert = false
    var alertModel = AlertModel()

    init(factory: MainScreenFactory) {
        self.factory = factory
        tags = ProductSection.allCases.map(factory.covertToTagSection)
    }

    func showAlert(_ alert: AlertModel) {
        alertModel = alert
        showAlert = true
    }
}
