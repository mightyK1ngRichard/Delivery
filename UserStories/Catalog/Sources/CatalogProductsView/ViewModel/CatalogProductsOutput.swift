//
//  Created by Dmitriy Permyakov on 27.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol CatalogProductsOutput: AnyObject {
    func catalogProductsOpenProductDetails(product: ProductModel)
    func catalogProductsShowAlertError(message: String)
}
