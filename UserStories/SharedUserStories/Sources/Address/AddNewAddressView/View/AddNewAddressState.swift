//
// Created by Dmitriy Permyakov on 29.06.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DesignSystem

final class AddNewAddressState: ObservableObject {

    @Published
    var nameInput = ""
    @Published
    var addressInput = ""
    @Published
    var cityInput = ""
    @Published
    var streetInput = ""
    @Published
    var homeNumberInput = ""
    @Published
    var apartamentNumberInput = ""
    @Published
    var buttonState: ButtonState = .default

    var buttonIsDisabled: Bool {
        nameInput.isEmpty
            || addressInput.isEmpty
            || cityInput.isEmpty
            || streetInput.isEmpty
            || homeNumberInput.isEmpty
            || apartamentNumberInput.isEmpty
            || buttonState != .default
    }
}
