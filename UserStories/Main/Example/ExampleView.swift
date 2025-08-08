//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import Resolver
import DependencyRegistry
@testable import Main

@main
struct ExampleView: App {

    let delegate = Delegate()

    init() {
        Resolver.registerAll()
    }

    var body: some Scene {
        WindowGroup {
            MainScreenAssembly.assemble(output: delegate)
        }
    }
}

extension ExampleView {

    final class Delegate: MainScreenOutput {

        func openProductDetatails(product: Main.Product) {}

        func openAllProducts(sectionTitle: String, products: [Main.Product]) {}

        func openPopcats(id: Int, title: String) {}

        func openPickAddressScreen() {}

        func openAuthScreen() {}

        func showAlert(title: String, message: String) {}

        func showAuthAlert(title: String, message: String) {}

        func showAddAddressAlert(title: String, message: String, token: String) {}

        func incrementCartCount() {}

        func decrementCartCount() {}

        func addProductToBasket(product: Main.Product, count: Int) {}

        func incrementProductCountInBasket(productID: Int, count: Int) {}

        func decrementProductCountInBasket(productID: Int, count: Int) {}
    }
}
