//
//  Created by Dmitriy Permyakov on 27.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import AuthService
import DLCore
import AuthInterface

final class LoginScreenViewModel {

    private let state: LoginScreenViewState
    private let neworkClient: AnyLoginScreenNetworkClient
    private weak var output: LoginScreenOutput?

    private let logger = DLLogger("Login Screen View Model")

    init(
        state: LoginScreenViewState,
        neworkClient: AnyLoginScreenNetworkClient,
        output: LoginScreenOutput
    ) {
        self.state = state
        self.neworkClient = neworkClient
        self.output = output
    }
}

// MARK: - AuthViewOutput

extension LoginScreenViewModel: LoginScreenViewOutput {

    func onFirstAppear() {
        logger.logEvent()
    }

    func onTapRememberMeButton() {
        logger.logEvent()
        state.hasRememberMe.toggle()
    }

    func onTapDontRememberPasswordButton() {
        logger.logEvent()
    }

    func onTapCloseButton() {
        logger.logEvent()
        output?.authScreenDidClose()
    }

    func onTapVisibility() {
        logger.logEvent()
        state.hasHiddenInput.toggle()
    }

    func onTapSignInButton() {
        logger.logEvent()

        state.buttonState = .loading
        Task {
            do {
                try await neworkClient.makeLogin(email: state.emailInput, password: state.passwordInput)
                output?.authScreenDidSignInSuccess()
                state.buttonState = .default
            } catch {
                logger.error(error)
                output?.authScreenShowAlert(.init(
                    title: "Ошибка авторизации",
                    subtitle: "Повторите попытку позже"
                ))
            }
            state.buttonState = .default
        }
    }
}
