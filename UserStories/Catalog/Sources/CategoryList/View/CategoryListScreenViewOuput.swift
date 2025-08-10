//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol CategoryListScreenViewOuput {
    func onFirstAppear()
    func onTapReloadButton()
    func onTapCategoryCell(category: CategoryModel)
}
