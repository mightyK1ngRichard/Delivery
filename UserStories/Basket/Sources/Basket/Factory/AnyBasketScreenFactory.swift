//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories
import SharedContractsInterface
import DesignSystem

protocol AnyBasketScreenFactory {
    func convertToProduct(from entity: ProductEntity) -> ProductModel?
    func convertToProductHCard(from model: ProductModel) -> DLProductHCard.Configuration
    func makePriceFormatting(for price: Double) -> String
}
