//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

enum CatalogCoordinatorAssembly {

    @MainActor
    static func assemble() -> CatalogCoordinator {
        CatalogCoordinator(router: .init())
    }
}
