//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import DesignSystem
import Foundation
import SharedUserStories

protocol AnyAllProductsScreenFactory {
    func convertToDProductCard(from model: Product) -> DProductCardModel
}

struct AllProductsScreenFactory: AnyAllProductsScreenFactory {

    let productFactory: AnyProductFactory

    func convertToDProductCard(from model: Product) -> DProductCardModel {
        productFactory.convertToDProductCard(from: model)
    }
}
