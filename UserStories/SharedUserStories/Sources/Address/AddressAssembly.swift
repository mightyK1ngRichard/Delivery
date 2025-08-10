//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import Coordinator

public enum AddressAssembly {

    @MainActor
    public static func assemble(router: Router<AddressRoute>) -> AddressCoordinator {
        AddressCoordinator(router: router)
    }
}
