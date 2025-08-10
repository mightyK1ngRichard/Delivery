//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import CatalogServiceInterface
import SharedUserStories

protocol AnyCategoryFactory {
    func convertToCategory(from entity: CategoryEntity) -> CategoryModel?
}

struct CategoryFactory: AnyCategoryFactory {

    let mediaFactory: AnyMediaFactory

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
