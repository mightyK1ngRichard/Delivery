//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DependencyRegistry
import MainInterface
import Resolver

@main
struct DeliveryApp: App {

    let delegate = Delegate()

    init() {
        Resolver.registerAll()
    }

    var body: some Scene {
        WindowGroup {
            RootAssembly.assemble(output: delegate)
        }
    }
}

final class Delegate: MainCoordinatorOutput {

    func incrementCartCount() {
    }

    func decrementCartCount() {
    }

    func openAuthScreen() {
    }
}

enum RootAssembly {

    @MainActor
    static func assemble(output: MainCoordinatorOutput) -> some View {
        let state = RootScreenViewState()
        let mainCoordinator = Resolver.resolve(AnyMainAssembly.self).assemble(output: output)

        return RootScreenView(state: state, mainCoordinator: mainCoordinator)
    }
}
