//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import SharedUserStories

final class UserDataViewState: ObservableObject {

    @Published
    var screenState: ScreenState = .loading
    @Published
    var phoneInput = String()
    @Published
    var emailInput = String()
    @Published
    var kppInput = String()
    @Published
    var innInput = String()
    @Published
    var companyNameInput = String()
    @Published
    var confirmationEmailСodeInput = String()
    @Published
    var confirmationPhoneСodeInput = String()

    var codeForEmailDidEntered: Bool {
        !confirmationEmailСodeInput.isEmpty
    }

    var codeForPhoneDidEntered: Bool {
        !confirmationPhoneСodeInput.isEmpty
    }
}

extension UserDataViewState {

    func setUserData(user: UserModel) {
        emailInput = user.email
        phoneInput = user.phone
        companyNameInput = user.name
        innInput = user.inn
        kppInput = user.kpp
    }
}
