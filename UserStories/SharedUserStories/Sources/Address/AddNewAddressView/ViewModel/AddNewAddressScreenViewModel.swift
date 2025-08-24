//
//  Created by Dmitriy Permyakov on 13.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DLCore

final class AddNewAddressScreenViewModel {

    private let state: AddNewAddressState
    private let networkClient: AnyAddNewAddressScreenNetworkClient
    private weak var output: AddNewAddressScreenOutput?
    private let logger = DLLogger("AddNewAddressViewModel")

    init(
        state: AddNewAddressState,
        networkClient: AnyAddNewAddressScreenNetworkClient,
        output: AddNewAddressScreenOutput
    ) {
        self.state = state
        self.networkClient = networkClient
        self.output = output
    }
}

// MARK: - AddNewAddressViewOutput

extension AddNewAddressScreenViewModel: AddNewAddressViewOutput {

    func onFirstAppear() {
        logger.logEvent()
    }

    func onTapSendButton() {
        logger.logEvent()
        state.buttonState = .loading
        Task {
            defer { state.buttonState = .default }
            do {
                try await networkClient.saveAddress(
                    payload: .init(
                        addressID: "0",
                        title: state.nameInput,
                        city: state.cityInput,
                        street: state.streetInput,
                        house: state.homeNumberInput,
                        flat: state.apartamentNumberInput
                    )
                )
                output?.addNewAddressDidFinishWithSuccess()
            } catch {
                logger.error(error.localizedDescription)
            }
        }
    }
}
