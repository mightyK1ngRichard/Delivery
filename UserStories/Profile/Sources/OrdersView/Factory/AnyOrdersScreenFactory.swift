//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import UserServiceInterface
import DesignSystem

protocol AnyOrdersScreenFactory {
    func convertToOrder(from entity: OrderEntity) -> Order?
    func converToOrderCell(from model: Order) -> DLOrderInfoCell.Configuration
}
