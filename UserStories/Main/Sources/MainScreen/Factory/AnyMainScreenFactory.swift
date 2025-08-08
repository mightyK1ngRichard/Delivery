//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import DesignSystem
import SharedContractsInterface
import BannerServiceInterface
import PopcatsServiceInterface

protocol AnyMainScreenFactory {
    func convertToProduct(from entity: ProductEntity) -> Product?
    func convertToDProductCard(from model: Product) -> DProductCardModel
    func convertToDCategoryModel(from model: Popcat) -> DCategoryModel
    func convertToBannerPage(from entity: BannerEntity) -> BannerPage?
    func convertToPopcat(from entity: PopcatsEntity) -> Popcat?
    func covertToTagSection(from model: ProductSection) -> DTagsSection.Section
}
