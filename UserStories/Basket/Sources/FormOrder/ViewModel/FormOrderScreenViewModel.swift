//
//  Created by Dmitriy Permyakov on 12.07.2025.
//  Copyright © 2025 Dostavka24 LLC. All rights reserved.
//

import DLCore
import SharedUserStories
import BasketInterface
import OrderServiceInterface

/**
 всем привет. по пунктам
 2. дата - текущая дата плюс сутки. выставить счет - там должен быть селект, который передает переменную payment_type, 2 - выставить счет, 1 - Наличные
 3. список статусов - /order/statuses, насчет оплаты - payment_type выше
 4. source
*/
final class FormOrderScreenViewModel {
    
    private let state: FormOrderScreenViewState
    private let orderService: AnyOrderService
    private weak var output: FormOrderScreenOutput?

    private let logger = DLLogger("Form Order Screen")

    @MainActor
    init(
        state: FormOrderScreenViewState,
        orderService: AnyOrderService,
        output: FormOrderScreenOutput
    ) {
        self.state = state
        self.orderService = orderService
        self.output = output

        output.formOrderInput = self
    }
}

// MARK: - FormOrderScreenInput

extension FormOrderScreenViewModel: FormOrderScreenInput {

    func updatePaymentKind(_ newKind: PaymentKind) {
        logger.logEvent()
        state.selectedPaymentKind = newKind
    }
}

// MARK: - FormOrderScreenViewOutput

extension FormOrderScreenViewModel: FormOrderScreenViewOutput {

    func onFirstAppear() {
        logger.logEvent()
    }

    func onTapApplyBonuses() {
        logger.logEvent()
        if let count = Int(state.inputBonusesCount), count % 100 == 0 {
            state.bonusesIncluded = true
            state.bonusesCount = count
        } else {
            state.showAlert(.init(
                title: "Ошибка добавления бонусов",
                subtitle: "Бонусы должны быть кратными 100"
            ))
        }
    }

    func onTapChoosePaymentType() {
        logger.logEvent()
        output?.formOrderDidChoosePaymentType(state.selectedPaymentKind)
    }

    func onTapMakeOrder() {
        logger.logEvent()
        if state.bonusesCount == nil, state.bonusesIncluded {
            state.showAlert(.init(
                title: "Некорректный ввод",
                subtitle: "Вы выбрали бонусы, но не применили их корректно"
            ))
            return
        }

        state.buttonState = .loading
        Task {
            do {
                try await orderService.makeOrder(body: .init(
                    bonus: state.bonusesCount ?? 0,
                    paymentType: String(state.selectedPaymentKind.rawValue),
                    products: state.products.map {
                        .init(id: $0.id, count: $0.count)
                    }
                ))
                state.showSuccessView = true
            } catch {
                logger.error(error.localizedDescription)
                state.showAlert(.init(title: "Ошибка", subtitle: "Ошибка формирования заказа. Попробуйте позже"))
            }
            state.buttonState = .default
        }
    }

    func onTapOpenProductsList() {
        logger.logEvent()
    }

    func onTapOpenCatalogScreen() {
        logger.logEvent()
        state.showSuccessView = false
        output?.formOrderDidTapOpenCatalog()
    }

    func onTapProduct(productID: Int) {
        logger.logEvent()
//        guard let product = state.products.first(where: { $0.id == productID }) else {
//            logger.error("Продукт с ID \(productID) не найден")
//            return
//        }
    }
}
