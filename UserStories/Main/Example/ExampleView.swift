//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import Resolver
import DependencyRegistry
import Coordinator
@testable import Main

@main
struct ExampleView: App {

    init() {
        Resolver.registerAll()
    }

    var body: some Scene {
        WindowGroup {
            NavigatableView(coordinator: MainAssembly.assemble())
        }
    }
}

extension ExampleView {

}
