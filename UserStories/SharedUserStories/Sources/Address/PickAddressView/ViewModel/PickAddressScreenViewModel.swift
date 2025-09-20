//
//  Created by Dmitriy Permyakov on 13.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import UserServiceInterface

final class PickAddressScreenViewModel: Sendable {

    private let state: PickAddressScreenViewState
    private let userService: AnyUserService
    private let networkClient: AnyPickAddressScreenNetworkClient
    private let factory: AnyPickAddressScreenFactory

    @MainActor
    private weak var output: PickAddressScreenOutput?

    private let logger = DLLogger("Pick Address View Model")

    init(
        state: PickAddressScreenViewState,
        userService: AnyUserService,
        networkClient: AnyPickAddressScreenNetworkClient,
        factory: AnyPickAddressScreenFactory,
        output: PickAddressScreenOutput
    ) {
        self.state = state
        self.userService = userService
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

    func onPickAddress(address: Address) {
        logger.logEvent()
        state.selectedAddressID = address.id
        updateSelectedAddress(address: address)
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
                let selectedAddress = address.first(where: \.isMain)
                if let selectedAddress {
                    userService.setAddressTitle(selectedAddress.title)
                }

                state.selectedAddressID = selectedAddress?.id
                state.addresses = address
                state.state = .content
            } catch {
                logger.error(error)
                state.state = .error
            }
        }
    }

    func updateSelectedAddress(address: Address) {
        Task {
            do {
                try await networkClient.updateUserAddress(address: address)
                userService.setAddressTitle(address.title)
            } catch {
                logger.error(error)
            }
        }
    }
}
