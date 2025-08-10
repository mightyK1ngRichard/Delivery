//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Coordinator

@MainActor
public protocol AnyCatalogCoordinator: Navigatable where Route == CatalogRoute {}
