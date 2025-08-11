//
//  Created by Dmitriy Permyakov on 12.07.2025.
//  Copyright © 2025 Dostavka24 LLC. All rights reserved.
//

import DLCore
import SharedUserStories

/**
 всем привет. по пунктам
 2. дата - текущая дата плюс сутки. выставить счет - там должен быть селект, который передает переменную payment_type, 2 - выставить счет, 1 - Наличные
 3. список статусов - /order/statuses, насчет оплаты - payment_type выше
 4. source
*/
final class FormOrderScreenViewModel {
    
    private let state: FormOrderScreenViewState
    private weak var output: FormOrderScreenOutput?

    private let logger = DLLogger("Form Order Screen")

    init(
        state: FormOrderScreenViewState,
        output: FormOrderScreenOutput
    ) {
        self.state = state
        self.output = output
    }
}

// MARK: - FormOrderScreenViewOutput

extension FormOrderScreenViewModel: FormOrderScreenViewOutput {

    func onFirstAppear() {
        logger.logEvent()
    }

    func onTapApplyBonuses() {
        logger.logEvent()
    }

    func onTapMakeOrder() {
        logger.logEvent()
//        output?.formOrderDidOpenMakeOrderScren(orderModel: <#T##OrderModel#>)
    }

    func onTapOpenProductsList() {
        logger.logEvent()
    }

    func onTapProduct(productID: Int) {
        logger.logEvent()
//        guard let product = state.products.first(where: { $0.id == productID }) else {
//            logger.error("Продукт с ID \(productID) не найден")
//            return
//        }
    }
}
