//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import DLCore

@MainActor
final class RootScreenViewState: ObservableObject {

    @Published
    var tabItem: TabBarItem = .house
    @Published
    var screenState: ScreenState = .loading
    @Published
    var showBasketFlow = false
    @Published
    var basketBadge = 0
    @Published
    var profileBadge = 0
    @Published
    var balance: Double?
}

extension RootScreenViewState {

    func resetAll() {
        showBasketFlow = false
        basketBadge = 0
        profileBadge = 0
        balance = nil
    }
}
