//
//  Created by Dmitriy Permyakov on 12.07.2025.
//  Copyright © 2025 Dostavka24 LLC. All rights reserved.
//

import SharedUserStories

@MainActor
protocol FormOrderScreenViewOutput {
    func onFirstAppear()
    func onTapApplyBonuses()
    func onTapMakeOrder()
    func onTapOpenProductsList()
    func onTapProduct(productID: Int)
    func onTapChoosePaymentType()
}
