//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories
import UserServiceInterface

struct UserDataScreenFactory: AnyUserDataScreenFactory {

    func convertToUser(from entity: UserEntity) -> UserModel? {
        guard let id = entity.id,
              let email = entity.email,
              let phone = entity.phone,
              let name = entity.name,
              let address = entity.address,
              let inn = entity.inn,
              let kpp = entity.kpp,
              let balance = entity.balance
        else { return nil }

        return .init(
            id: id,
            email: email,
            phone: phone,
            name: name,
            address: address,
            inn: inn,
            kpp: kpp,
            balance: balance
        )
    }
}
