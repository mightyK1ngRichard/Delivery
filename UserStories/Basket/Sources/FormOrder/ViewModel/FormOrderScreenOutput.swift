//
//  Created by Dmitriy Permyakov on 12.07.2025.
//  Copyright © 2025 Dostavka24 LLC. All rights reserved.
//

import BasketInterface
import SharedUserStories

@MainActor
protocol FormOrderScreenOutput: AnyObject {
    var formOrderInput: FormOrderScreenInput? { get set }

    func formOrderDidChoosePaymentType(_ kind: PaymentKind)
    func formOrderDidTapOpenCatalog()
}

@MainActor
protocol FormOrderScreenInput: AnyObject {
    func updatePaymentKind(_: PaymentKind)
}
