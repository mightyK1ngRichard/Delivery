//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import SharedUserStories
import DependencyRegistry
import Resolver
@testable import Basket

@main
struct BasketExample: App {

    let delegate = Delegate()

    init() {
        UserDefaults.standard.set("bo0Qpjcsjq5r94qI", forKey: "userToken")
        UserDefaults.standard.set(1995, forKey: "addressID")
        Resolver.registerAll()
    }

    var body: some Scene {
        WindowGroup {
            BasketAssembly.assemble(output: delegate)
        }
    }
}

final class Delegate: BasketScreenOutput {

    func basketScreenDidOpenProductDetails(productID: Int) {}

    func basketScreenDidOpenCatalog() {}

    func basketScreenDidOpenMakeOrderScreen(products: [ProductModel]) {}

    func basketScreenDidShowAlert(with alert: AlertModel) {}
}
