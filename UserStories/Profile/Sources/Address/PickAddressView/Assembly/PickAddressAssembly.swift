//
//  Created by Dmitriy Permyakov on 29.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import Resolver
import OrderServiceInterface

@MainActor
enum PickAddressAssembly {

    static func assemble(output: PickAddressScreenOutput) -> some View {
        let state = PickAddressScreenViewState()
        let networkClient = PickAddressScreenNetworkClient(orderService: Resolver.resolve(AnyOrderService.self))
        let factory = PickAddressScreenFactory()
        let viewModel = PickAddressScreenViewModel(
            state: state,
            networkClient: networkClient,
            factory: factory,
            output: output
        )

        return PickAddressScreenView(state: state, output: viewModel)
    }
}
