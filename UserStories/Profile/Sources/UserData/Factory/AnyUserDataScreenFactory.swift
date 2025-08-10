//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories
import UserServiceInterface

protocol AnyUserDataScreenFactory {
    func convertToUser(from entity: UserEntity) -> UserModel?
}
