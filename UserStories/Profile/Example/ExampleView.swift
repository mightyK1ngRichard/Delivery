//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DependencyRegistry
import Resolver
import SharedUserStories
import Coordinator
@testable import Profile

@main
struct ExampleView: App {

    let delegate = Delegate()

    init() {
        Resolver.registerAll()
    }

    var body: some Scene {
        WindowGroup {
            NavigatableView(coordinator: ProfileAssembly.assemble())
        }
    }
}

final class Delegate: ProfileScreenOutput {

    func openUserDataScreen() {}

    func openOrdersScreen() {}

    func openAddressesScreen() {}

    func openProductDetails(product: Product) {}

    func openSignInFlow() {}

    func openSignUpFlow() {}

    func showAlert(title: String, message: String) {}

    func logout() {}
}
