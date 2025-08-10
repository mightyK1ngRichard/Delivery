//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import Coordinator

enum AddressAssembly {

    @MainActor
    static func assemble(router: Router<AddressRoute>) -> AddressCoordinator {
        AddressCoordinator(router: router)
    }
}
