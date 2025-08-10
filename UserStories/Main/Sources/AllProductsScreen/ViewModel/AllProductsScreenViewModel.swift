//
//  Created by Dmitriy Permyakov on 03.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import Foundation
import DLCore
import SharedUserStories

final class AllProductsScreenViewModel {

    private let state: AllProductsScreenViewState
    private weak var output: AllProductsScreenOutput?

    private let logger = DLLogger("All Products Screen View Model")

    init(
        state: AllProductsScreenViewState,
        output: AllProductsScreenOutput
    ) {
        self.state = state
        self.output = output
    }
}

// MARK: - AllProductsScreenViewOutput

extension AllProductsScreenViewModel: AllProductsScreenViewOutput {

    func onFirstAppear() {
        logger.logEvent()
    }

    func onTapProductCard(for product: ProductModel) {
        logger.logEvent()
        output?.didTapOpenProuctDetails(with: product)
    }

    func onTapProductLike(productID: Int, isLike: Bool) {
        logger.logEvent()
    }

    func onTapProductPlus(productID: Int, counter: Int) {
        logger.logEvent()
    }

    func onTapProductMinus(productID: Int, counter: Int) {
        logger.logEvent()
    }

    func onTapProductBasket(productID: Int, counter: Int) {
        logger.logEvent()
    }
}
