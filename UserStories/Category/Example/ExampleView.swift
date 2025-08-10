//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SharedUserStories
import SwiftUI
import Resolver
import DependencyRegistry
@testable import Category

@main
struct ExampleView: App {

    let delegate = Delegate()

    init() {
        Resolver.registerAll()
    }

    var body: some Scene {
        WindowGroup {
            CatalogAssembly.assemble(output: delegate)
        }
    }
}

final class Delegate: CatalogOutput {

    func openCategoryList(category: CategoryModel) {
    }

    func openLookAllProducts(navigationTitle: String, products: [ProductModel]) {
    }

    func openProductDetails(product: ProductModel) {
    }
}
