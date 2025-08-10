//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import OrderServiceInterface

struct PickAddressScreenFactory: AnyPickAddressScreenFactory {

    func convertToAddress(from entity: AddressEntity) -> Address? {
        guard let id = entity.id,
              let title = entity.title
        else { return nil }

        return Address(id: id, title: title, isMain: entity.isMain == 1)
    }
}
