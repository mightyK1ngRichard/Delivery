//
//  Created by Dmitriy Permyakov on 12.07.2025.
//  Copyright © 2025 Dostavka24 LLC. All rights reserved.
//

import SwiftUI
import SharedUserStories
import BasketInterface

@MainActor
enum FormOrderAssembly {

    static func assemble(orderModel: OrderModel, output: FormOrderScreenOutput) -> some View {
        let priceFactory = PriceFactory()
        let factory = FormOrderScreenFactory(priceFactory: priceFactory)

        let state = FormOrderScreenViewState(
            factory: factory,
            resultSum: orderModel.totalAmount.formatedPrice,
            cashback: String(orderModel.receiveCashback),
            deliveryPrice: orderModel.deliveryPrice == 0
                ? "Бесплатно"
                : factory.makeFormattingPrice(for: orderModel.deliveryPrice),
            products: orderModel.products
        )
        let viewModel = FormOrderScreenViewModel(
            state: state,
            output: output
        )

        return FormOrderScreenView(state: state, output: viewModel)
    }
}
