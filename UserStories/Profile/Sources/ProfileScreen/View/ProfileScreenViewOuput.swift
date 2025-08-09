//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol ProfileScreenViewOuput {
    func onFirstAppear()
    func onTapReloadData()
    func onTapMenuCell(_ cell: ProfileScreenViewState.MenuCell)
    func onTapRegistrationButton()
    func onTapSignInButton()
    func onTapProduct(product: Product)
}
