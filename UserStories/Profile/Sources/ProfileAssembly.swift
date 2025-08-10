//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import ProfileInterface

public struct ProfileAssembly: AnyProfileAssembly {

    public init() {}

    public func assemble() -> any AnyProfileCoordinator {
        ProfileCoordinator(router: .init())
    }
}
