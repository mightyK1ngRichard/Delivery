//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import BasketInterface

public struct BasketAssembly: AnyBasketAssembly {

    public init() {}

    public func assemble() -> any AnyBasketCoordinator {
        BasketCoordinator(router: .init())
    }
}
