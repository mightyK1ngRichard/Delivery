//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories

struct ProductDetailsScreenFactory: AnyProductDetailsScreenFactory {

    func makeBasketButtonTitle(from model: Product) -> String {
        "\(model.packageCount.count) шт · \(model.formattedPrice)"
    }
}
