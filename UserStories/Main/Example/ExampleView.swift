//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import Resolver
import DependencyRegistry
import Coordinator
import MainInterface

@main
struct ExampleView: App {

    init() {
        Resolver.registerAll()
    }

    let delegte = Delegate()

    var body: some Scene {
        WindowGroup {
            let coordinator = Resolver.resolve(AnyMainAssembly.self).assemble(output: delegte)
            NavigatableView(coordinator: coordinator)
        }
    }
}

extension ExampleView {

    final class Delegate: MainCoordinatorOutput {
        func incrementCartCount() {

        }

        func decrementCartCount() {

        }

        func openAuthScreen() {

        }
    }
}
