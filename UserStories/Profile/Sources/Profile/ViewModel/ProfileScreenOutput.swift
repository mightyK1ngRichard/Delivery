//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import SharedUserStories

@MainActor
protocol ProfileScreenOutput: AnyObject {
    var profileInput: ProfileScreenInput? { get set }

    func openUserDataScreen()
    func openOrdersScreen()
    func openAddressesScreen()
    func openProductDetails(product: ProductModel)
    func openSignInFlow()
    func openSignUpFlow()
    func showAlert(title: String, message: String)
    func logout()
}

@MainActor
protocol ProfileScreenInput: AnyObject {
    func didLoginSuccessfully()
}
