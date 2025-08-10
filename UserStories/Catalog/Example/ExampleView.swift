//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories
import SwiftUI
import Coordinator
import Resolver
import DependencyRegistry
@testable import Catalog

@main
struct ExampleView: App {

    init() {
        Resolver.registerAll()
    }

    var body: some Scene {
        WindowGroup {
            NavigatableView(coordinator: CatalogCoordinatorAssembly.assemble())
        }
    }
}
