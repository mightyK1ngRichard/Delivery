//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import DLNetwork
import UserServiceInterface

struct ProfileScreenNetworkClient: AnyProfileScreenNetworkClient {

    let userService: AnyUserService

    func getNotificationWarnings() async throws -> [NotificationWarning] {
        try await userService.getNotificationWarnings()
    }
}
