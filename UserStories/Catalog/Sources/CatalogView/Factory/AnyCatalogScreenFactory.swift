//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedContractsInterface
import CatalogServiceInterface
import SharedUserStories
import DesignSystem

protocol AnyCatalogScreenFactory: Sendable {
    
    func convertToDProductCard(from model: ProductModel) -> DProductCardModel
    func convertToProduct(from entity: ProductEntity) -> ProductModel?
    func convertToDLCategoryBlockData(from model: CategoryModel) -> DLCategoryBlock.Configuration.CellData
    func convertToCategory(from entity: CategoryEntity) -> CategoryModel?
}
