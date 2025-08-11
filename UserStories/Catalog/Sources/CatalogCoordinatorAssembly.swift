//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import CatalogInterface

public struct CatalogCoordinatorAssembly: AnyCatalogAssembly {

    public init() {}

    public func assemble(output: CatalogOutput) -> any AnyCatalogCoordinator {
        CatalogCoordinator(router: .init(), output: output)
    }
}
