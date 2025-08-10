//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import MainInterface
import SwiftUI
import Coordinator

@MainActor
public struct MainAssembly: AnyMainAssembly {

    public init() {}

    public func assemble(output: MainCoordinatorOutput) -> any AnyMainCoordinator {
        MainCoordinator(router: .init(), output: output)
    }
}
