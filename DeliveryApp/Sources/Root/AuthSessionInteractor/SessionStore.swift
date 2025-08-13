//
//  Created by Dmitriy Permyakov on 13.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import SharedUserStories

protocol AnySessionStore: Sendable, Actor {

    var hasAddressDelivery: Bool { get }
    var userEmailIsCheched: Bool { get }
    var userBalance: Double? { get }
    var userPhoneIsCheched: Bool { get }
    var basketProductIDs: Set<Int> { get }

    func clearAll() async
    func setHasAddressDelivery(_ hasAddressDelivery: Bool) async
    func setUserEmailCheched() async
    func setUserPhoneCheched() async
    func updateUserBalance(_ balance: Double) async
}

actor SessionStore: AnySessionStore {

    var hasAddressDelivery = false
    var userEmailIsCheched = false
    var userPhoneIsCheched = false
    var userBalance: Double?
    var basketProductIDs: Set<Int> = []

    func clearAll() async {
        hasAddressDelivery = false
        userEmailIsCheched = false
        userPhoneIsCheched = false
        userBalance = nil
        basketProductIDs.removeAll()
    }

    func setHasAddressDelivery(_ hasAddressDelivery: Bool) async {
        self.hasAddressDelivery = hasAddressDelivery
    }

    func setUserEmailCheched() async {
        userEmailIsCheched = true
    }

    func setUserPhoneCheched() async {
        userPhoneIsCheched = true
    }

    func updateUserBalance(_ balance: Double) async {
        userBalance = balance
    }
}
