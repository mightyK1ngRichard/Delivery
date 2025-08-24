//
//  Created by Dmitriy Permyakov on 29.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation
import DLCore

@MainActor
final class PickAddressScreenViewState: ObservableObject, Sendable {

    @Published
    var state: ScreenState = .loading

    @Published
    var addresses: [Address] = []

    @Published
    var selectedAddressID: Int?
}
