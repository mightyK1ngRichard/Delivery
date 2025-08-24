//
//  Created by Dmitriy Permyakov on 29.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SwiftUI
import Resolver
import DLNetwork

@MainActor
enum AddNewAddressAssembly {

    static func assemble(output: AddNewAddressScreenOutput) -> some View {
        let state = AddNewAddressState()
        let networkClient = AddNewAddressScreenNetworkClient(networkClient: Resolver.resolve(AnyNetworkClient.self))
        let viewModel = AddNewAddressScreenViewModel(
            state: state,
            networkClient: networkClient,
            output: output
        )

        return AddNewAddressView(state: state, output: viewModel)
    }
}
