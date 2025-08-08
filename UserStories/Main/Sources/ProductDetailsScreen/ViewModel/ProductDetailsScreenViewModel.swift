//
//  Created by Dmitriy Permyakov on 25.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DLCore

final class ProductDetailsScreenViewModel {

    private let state: ProductDetailsScreenViewState
    private let factory: AnyProductDetailsScreenFactory
    private weak var output: ProductDetailsScreenOutput?

    private let logger = DLLogger("Product Details Screen View Model")

    init(
        state: ProductDetailsScreenViewState,
        factory: AnyProductDetailsScreenFactory,
        output: ProductDetailsScreenOutput
    ) {
        self.state = state
        self.factory = factory
        self.output = output
    }
}

// MARK: - ProductDetailsViewOutput

extension ProductDetailsScreenViewModel: ProductDetailsViewOutput {

    func onFirstAppear() {
        logger.logEvent()
        state.makeBasketButtonTitle = factory.makeBasketButtonTitle(from: state.product)
    }

    func onTapAddIntoBasketButton() {
        logger.logEvent()
    }

    func onTapLike() {
        logger.logEvent()
    }

    func onTapShare() {
        logger.logEvent()
    }
}
