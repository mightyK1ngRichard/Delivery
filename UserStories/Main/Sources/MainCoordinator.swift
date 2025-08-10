//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DLCore
import Coordinator
import SharedUserStories
import MainInterface

final class MainCoordinator: Navigatable, AnyMainCoordinator {

    let router: Router<MainRoute>
    let logger = DLLogger("Main Coordinator")
    private weak var output: MainCoordinatorOutput?
    private let addressCoordinator: AddressCoordinator

    @MainActor
    init(router: Router<MainRoute>, output: MainCoordinatorOutput?) {
        self.router = router
        self.output = output
        addressCoordinator = AddressAssembly.assemble(router: .init())
    }

    func run() -> some View {
        destination(.main)
    }

    @ViewBuilder
    func destination(_ route: MainRoute) -> some View {
        switch route {
        case .main:
            MainScreenAssembly
                .assemble(output: self)
        case let .product(product):
            ProductDetailsAssembly
                .assemble(product: product, output: self)
        case let .lookAll(navigationTitle, products):
            AllProductsScreenAssembly
                .assemble(products: products, navigationTitle: navigationTitle, output: self)
        case .addressFlow:
            NavigatableView(addressCoordinator)
        }
    }
}

// MARK: - ProductDetailsScreenOutput

extension MainCoordinator: ProductDetailsScreenOutput {}

// MARK: - AllProductsScreenOutput

extension MainCoordinator: AllProductsScreenOutput {

    func didTapOpenProuctDetails(with product: ProductModel) {
        logger.logEvent()
        router.push(.product(product))
    }
}
