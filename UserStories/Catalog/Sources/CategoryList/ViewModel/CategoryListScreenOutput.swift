//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol CategoryListScreenOutput: AnyObject {
    func categoryListDidOpenCategoryProductsScreen(category: CategoryModel, categories: [CategoryModel])
    func categoryListDidShowAlert(message: String)
}
