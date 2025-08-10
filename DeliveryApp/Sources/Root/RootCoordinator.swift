//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DLCore
import Coordinator
import SharedUserStories

//final class RootCoordinator: Navigatable {
//
//    let router: Router<MainRoutes>
//    let logger = DLLogger("Root Coordinator")
//
//    init(router: Router<MainRoutes>) {
//        self.router = router
//    }
//
//    func run() -> some View {
//        destination(.main)
//    }
//
//    @ViewBuilder
//    func destination(_ route: MainRoutes) -> some View {
//        switch route {
//        case .main:
//            MainScreenAssembly
//                .assemble(output: self)
//        case let .product(product):
//            ProductDetailsAssembly
//                .assemble(product: product, output: self)
//        case let .lookAll(navigationTitle, products):
//            AllProductsScreenAssembly
//                .assemble(products: products, navigationTitle: navigationTitle, output: self)
//        }
//    }
//}
