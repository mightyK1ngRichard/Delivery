//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import DesignSystem
import SharedContractsInterface
import BannerServiceInterface
import PopcatsServiceInterface
import SharedUserStories

protocol AnyMainScreenFactory: Sendable {

    func convertToProduct(from entity: ProductEntity) -> ProductModel?
    func convertToDProductCard(from model: ProductModel) -> DProductCardModel
    func convertToDCategoryModel(from model: PopcatModel) -> DCategoryModel
    func convertToBannerPage(from entity: BannerEntity) -> BannerPage?
    func convertToPopcat(from entity: PopcatsEntity) -> PopcatModel?
    func covertToTagSection(from model: ProductSection) -> DTagsSection.Section
}
