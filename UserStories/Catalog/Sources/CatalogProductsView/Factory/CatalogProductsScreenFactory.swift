//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories
import DesignSystem
import CatalogServiceInterface

struct CatalogProductsScreenFactory: AnyCatalogProductsScreenFactory {

    let productFactory: AnyProductFactory

    func convertToProduct(from entity: CategoryProductEntity) -> ProductModel? {
        productFactory.convertToProduct(from: entity)
    }

    func convertToDProductCard(from model: ProductModel) -> DProductCardModel {
        productFactory.convertToDProductCard(from: model)
    }
}
