//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import MainInterface
import DLCore

final class RootScreenViewModel {

    private let state: RootScreenViewState
    private let logger = DLLogger("Root Screen View Model")

    init(state: RootScreenViewState) {
        self.state = state
    }
}

// MARK: - MainCoordinatorOutput

extension RootScreenViewModel: MainCoordinatorOutput {

    func incrementCartCount() {
        logger.logEvent()
    }

    func decrementCartCount() {
        logger.logEvent()
    }

    func openAuthScreen() {
        logger.logEvent()
    }
}
