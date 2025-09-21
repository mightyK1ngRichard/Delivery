//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories
import CatalogServiceInterface
import DesignSystem

protocol AnyCatalogProductsScreenFactory: Sendable {

    func convertToProduct(from entity: CategoryProductEntity) -> ProductModel?
    func convertToDProductCard(from model: ProductModel) -> DProductCardModel
}
