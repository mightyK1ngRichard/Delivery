//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DLCore
import Coordinator

public final class AddressCoordinator: Navigatable {

    public let router: Router<AddressRoute>
    let logger = DLLogger("Address Coordinator")

    init(router: Router<AddressRoute>) {
        self.router = router
    }

    public func run() -> some View {
        destination(.addressesList)
    }

    @ViewBuilder
    public func destination(_ route: AddressRoute) -> some View {
        switch route {
        case .addressesList:
            PickAddressAssembly.assemble(output: self)
        case .addAddress:
            AddNewAddressAssembly.assemble(output: self)
        }
    }
}

// MARK: - PickAddressScreenOutput

extension AddressCoordinator: PickAddressScreenOutput {

    func openAddAddressScreen() {
        logger.logEvent()
        router.push(.addAddress)
    }
}

// MARK: - AddNewAddressScreenOutput

extension AddressCoordinator: AddNewAddressScreenOutput {
}
