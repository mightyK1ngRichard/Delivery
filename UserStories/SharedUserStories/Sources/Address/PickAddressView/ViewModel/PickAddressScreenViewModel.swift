//
//  Created by Dmitriy Permyakov on 13.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DLCore

final class PickAddressScreenViewModel: Sendable {

    private let state: PickAddressScreenViewState
    private let networkClient: AnyPickAddressScreenNetworkClient
    private let factory: AnyPickAddressScreenFactory

    @MainActor
    private weak var output: PickAddressScreenOutput?

    private let logger = DLLogger("Pick Address View Model")

    init(
        state: PickAddressScreenViewState,
        networkClient: AnyPickAddressScreenNetworkClient,
        factory: AnyPickAddressScreenFactory,
        output: PickAddressScreenOutput
    ) {
        self.state = state
        self.networkClient = networkClient
        self.factory = factory
        self.output = output
    }
}

// MARK: - PickAddressViewOutput

extension PickAddressScreenViewModel: PickAddressViewOutput {

    func onFirstAppear() {
        logger.logEvent()
        fetchData()
    }

    func onTapReloadButton() {
        logger.logEvent()
        fetchData()
    }

    func onPickAddress(addressID: Int) {
        logger.logEvent()
        state.selectedAddressID = addressID
        updateSelectedAddress(addressID: addressID)
    }

    func onTapAddNewAddress() {
        logger.logEvent()
        output?.openAddAddressScreen()
    }
}

// MARK: - Helpers

private extension PickAddressScreenViewModel {

    @MainActor
    func fetchData() {
        state.state = .loading

        Task {
            do {
                let entities = try await networkClient.fetchUserAddress()
                let address = entities.compactMap(factory.convertToAddress)
                let selectedAddressID = address.first(where: \.isMain)?.id

                state.selectedAddressID = selectedAddressID
                state.addresses = address
                state.state = .content
            } catch {
                logger.error(error)
                state.state = .error
            }
        }
    }

    func updateSelectedAddress(addressID: Int) {
        Task {
            do {
                try await networkClient.updateUserAddress(addressID: addressID)
            } catch {
                logger.error(error)
            }
        }
    }
}
