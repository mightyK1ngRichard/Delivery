//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DLCore
import Coordinator
import BasketInterface
import SharedUserStories

final class BasketCoordinator: Navigatable, AnyBasketCoordinator {

    let router: Router<BasketRoute>
    weak var formOrderInput: FormOrderScreenInput?
    private weak var output: BasketOutput?

    private let logger = DLLogger("Basket Coordinator")

    init(router: Router<BasketRoute>, output: BasketOutput) {
        self.router = router
        self.output = output
    }

    func run() -> some View {
        destination(.main)
    }

    func destination(_ route: BasketRoute) -> some View {
        switch route {
        case .main:
            BasketScreenAssembly
                .assemble(output: self)
        case let .productDetails(product):
            ProductDetailsAssembly
                .assemble(product: product, output: self)
        case let .makeOrder(orderModel):
            FormOrderAssembly
                .assemble(orderModel: orderModel, output: self)
        case let .paymentKindSheet(selectedKind):
            ChoosePaymentKindView(selectedItem: selectedKind, output: self)
                .presentationDetents([.height(250)])
        }
    }
}

// MARK: - BasketScreenOutput

extension BasketCoordinator: BasketScreenOutput {

    func basketScreenDidOpenProductDetails(product: ProductModel) {
        logger.logEvent()
        router.push(.productDetails(product: product))
    }

    func basketScreenDidOpenCatalog() {
        logger.logEvent()
        output?.basketDidOpenCatalog()
    }

    func basketScreenDidOpenMakeOrderScreen(orderModel: OrderModel) {
        logger.logEvent()
        router.push(.makeOrder(orderModel: orderModel))
    }

    func basketScreenDidShowAlert(with alert: AlertModel) {
        logger.logEvent()
    }

    func basketScreenDidDecrementCartCount() {
        logger.logEvent()
        output?.basketDidDecrementCartCount()
    }
}

// MARK: - ProductDetailsScreenOutput

extension BasketCoordinator: ProductDetailsScreenOutput {
}

// MARK: - FormOrderScreenOutput

extension BasketCoordinator: FormOrderScreenOutput {

    func formOrderDidOpenMakeOrderScren(orderModel: OrderModel) {
        logger.logEvent()
        router.push(.makeOrder(orderModel: orderModel))
    }

    func formOrderDidChoosePaymentType(_ kind: PaymentKind) {
        logger.logEvent()
        router.present(.paymentKindSheet(kind))
    }
}

// MARK: - ChoosePaymentKindViewOutput

extension BasketCoordinator: ChoosePaymentKindViewOutput {

    func didSelectPaymentKind(_ paymentKind: PaymentKind) {
        logger.logEvent()
        formOrderInput?.updatePaymentKind(paymentKind)
        router.dismiss()
    }
}
