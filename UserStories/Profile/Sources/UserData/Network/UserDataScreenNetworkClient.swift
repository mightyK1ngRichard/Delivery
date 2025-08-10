//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import UserServiceInterface
import DLNetwork

struct UserDataScreenNetworkClient: AnyUserDataScreenNetworkClient {

    let userService: AnyUserService

    func fetchProfile() async throws(NetworkClientError) -> UserEntity {
        try await userService.forceFetchProfile()
    }
}
