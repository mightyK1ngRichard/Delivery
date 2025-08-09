//
//  Created by Dmitriy Permyakov on 29.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore

final class OrdersViewState: ObservableObject {

    // MARK: Data

    @Published
    var orders: [Order] = []

    // MARK: UI

    @Published
    var searchText = String()

    @Published
    var screenState: ScreenState = .loading

    let factory: AnyOrdersScreenFactory

    init(factory: AnyOrdersScreenFactory) {
        self.factory = factory
    }
}
