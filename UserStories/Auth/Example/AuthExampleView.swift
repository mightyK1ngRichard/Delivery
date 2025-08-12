//
//  Created by Dmitriy Permyakov on 12.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import Resolver
import DependencyRegistry
import SwiftUI
import AuthInterface
import SharedUserStories
import Coordinator

@main
struct AuthExampleView: App {

    let delegate = Delegate()

    init() {
        Resolver.registerAll()
    }

    var body: some Scene {
        WindowGroup {
            NavigatableView(
                Resolver.resolve(AnyAuthAssembly.self)
                    .assemble(route: .signIn, output: delegate)
            )
        }
    }
}

final class Delegate: AuthOutput {
    
    func authCloseFlow() {
    }
}
