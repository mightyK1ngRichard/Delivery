//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DesignSystem

final class LoginScreenViewState: ObservableObject {

    @Published
    var buttonState: ButtonState = .default
    @Published
    var emailInput = "dimapermyakov55@gmail.com"
    @Published
    var passwordInput = "UK1XSJef"
    @Published
    var hasHiddenInput = false
    @Published
    var hasRememberMe = false

    var hasDisabledSignInButton: Bool {
        passwordInput.isEmpty
            || emailInput.isEmpty
            || !hasRememberMe
    }
}
