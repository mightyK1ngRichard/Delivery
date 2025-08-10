//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories
import CatalogServiceInterface

protocol AnyCategoryListFactory {
    func convertToCategory(from model: CategoryEntity) -> CategoryModel?
}
