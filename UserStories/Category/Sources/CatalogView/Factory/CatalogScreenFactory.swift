//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories
import SharedContractsInterface
import CatalogServiceInterface
import DesignSystem

struct CatalogScreenFactory: AnyCatalogScreenFactory {

    let productFactory: AnyProductFactory
    let mediaFactory: AnyMediaFactory

    func convertToDProductCard(from model: ProductModel) -> DProductCardModel {
        productFactory.convertToDProductCard(from: model)
    }

    func convertToProduct(from entity: ProductEntity) -> ProductModel? {
        productFactory.convertToProduct(from: entity)
    }

    func convertToDLCategoryBlockData(from model: CategoryModel) -> DLCategoryBlock.Configuration.CellData {
        .init(id: model.id, title: model.title, imageURL: model.imageURL)
    }

    func convertToCategory(from entity: CategoryEntity) -> CategoryModel? {
        guard let imageString = entity.image,
              let imageURL = mediaFactory.convertImageURL(from: imageString),
              let title = entity.title
        else { return nil }

        return CategoryModel(
            id: entity.id,
            imageURL: imageURL,
            title: title
        )
    }
}
