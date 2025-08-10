//
//  Created by Dmitriy Permyakov on 28.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

@MainActor
protocol UserDataViewOutput {

    func onFirstAppear()
    func onTapSaveButton()
    func onTapReloadData()
    func onTapConfirmPhoneCode()
    func onTapConfirmEmailCode()
    func onTapGetCall()

    /// Нажали кнопку `запросить код` по телефону
    func onTapRequestCodeForPhone()
    /// Нажали кнопку `запросить код` по email
    func onTapRequestCodeForEmail()
}
