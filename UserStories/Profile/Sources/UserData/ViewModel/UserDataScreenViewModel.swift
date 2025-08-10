//
//  Created by Dmitriy Permyakov on 05.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DLCore
import DLNetwork

final class UserDataScreenViewModel {

    private let state: UserDataViewState
    private let networkClient: AnyUserDataScreenNetworkClient
    private let factory: AnyUserDataScreenFactory
    private weak var output: UserDataScreenOutput?

    private let logger = DLLogger("UserDataViewModel")

    init(
        state: UserDataViewState,
        networkClient: AnyUserDataScreenNetworkClient,
        factory: AnyUserDataScreenFactory,
        output: UserDataScreenOutput
    ) {
        self.state = state
        self.networkClient = networkClient
        self.factory = factory
        self.output = output
    }
}

// MARK: - UserDataViewOutput

extension UserDataScreenViewModel: UserDataViewOutput {

    func onFirstAppear() {
        logger.logEvent()
        fetchData()
    }

    func onTapSaveButton() {
        logger.logEvent()
    }

    func onTapReloadData() {
        logger.logEvent()
        fetchData()
    }

    func onTapConfirmPhoneCode() {
        logger.logEvent()
    }

    func onTapConfirmEmailCode() {
        logger.logEvent()
    }

    func onTapGetCall() {
        logger.logEvent()
    }

    func onTapRequestCodeForPhone() {
        logger.logEvent()
    }

    func onTapRequestCodeForEmail() {
        logger.logEvent()
    }
}

extension UserDataScreenViewModel {

    @MainActor
    private func fetchData() {
        state.screenState = .loading

        Task {
            do {
                let userData = try await networkClient.fetchProfile()
                guard let user = factory.convertToUser(from: userData) else {
                    throw NetworkClientError.clientError(.invalidResponse)
                }

                state.setUserData(user: user)
                state.screenState = .content
            } catch {
                logger.error(error.localizedDescription)
                state.screenState = .error
            }
        }
    }
}
