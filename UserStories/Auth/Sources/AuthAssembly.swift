//
//  Created by Dmitriy Permyakov on 12.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import AuthInterface
import Coordinator

public struct AuthAssembly: AnyAuthAssembly {

    public init() {}

    public func assemble(route: AuthRoute, output: AuthOutput) -> any AnyAuthCoordinator {
        AuthCoordinator(router: .init(), startRoute: route, output: output)
    }
}
