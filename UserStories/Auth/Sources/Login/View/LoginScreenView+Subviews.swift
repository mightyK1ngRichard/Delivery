//
//  Created by Dmitriy Permyakov on 27.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DesignSystem

extension LoginScreenView {

    var mainContainer: some View {
        VStack(alignment: .leading, spacing: 0) {
            inputFieldsContainer
            rememberMeButton
            signInButton
            dontRememberButton
        }
        .padding(.horizontal)
        .padding(.top, 67)
        .navigationTitle("Вход в аккаунт")
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .alert(state.alertModel, showAlert: $state.showAlert)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: closeButton)
        }
        .background {
            DLIcon.gradientBG.image
                .resizable()
                .ignoresSafeArea()
        }
    }
}

private extension LoginScreenView {

    var signInButton: some View {
        DLButton(
            configuration: .init(
                state: state.buttonState,
                hasDisabled: state.hasDisabledSignInButton,
                titleView: {
                    Text("Войти")
                        .style(size: 16, weight: .semibold, color: DLColor<TextPalette>.white.color)
                },
                subtileView: { EmptyView() }
            ),
            action: {
                output.onTapSignInButton()
            }
        )
        .padding(.top, 26)
    }

    var dontRememberButton: some View {
        Button {
            output.onTapDontRememberPasswordButton()
        } label: {
            Text("Не помню пароль")
                .style(size: 14, weight: .regular, color: Constants.textDarkBlue)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 32)
    }

    var rememberMeButton: some View {
        Button {
            output.onTapRememberMeButton()
        } label: {
            HStack(spacing: .SPx1) {
                rememberMeIcon
                Text("Запонить меня")
                    .style(size: 13, weight: .regular, color: Constants.textPrimary)
            }
        }
        .padding(.top)
    }

    var inputFieldsContainer: some View {
        VStack(spacing: .SPx6) {
            emaiInputView
            passwordInputContainer
        }
    }

    var emaiInputView: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            titleView(title: "Адрес электронной почты")
            inputView(placeholder: "joedoe@gmail.com", text: $state.emailInput)
        }
    }

    var passwordInputContainer: some View {
        VStack(alignment: .leading, spacing: .SPx2) {
            titleView(title: "Пароль")
            passwordInputView
        }
    }

    var passwordInputView: some View {
        HStack(spacing: .SPx2) {
            passwordInputField
                .frame(height: 22)
            Button {
                output.onTapVisibility()
            } label: {
                visibilityIcon.frame(width: 20, height: 20)
            }
        }
        .padding(12)
        .overlay {
            fieldOverlay
        }
    }

    @ViewBuilder
    var rememberMeIcon: some View {
        if state.hasRememberMe {
            DLIcon.checkboxOn.image
                .frame(width: 16, height: 16)
        } else {
            DLIcon.checkboxOff.image
                .frame(width: 16, height: 16)
        }
    }

    @ViewBuilder
    var visibilityIcon: some View {
        if state.hasHiddenInput {
            DLIcon.visibilityOff.image
        } else {
            DLIcon.visibilityOn.image
        }
    }

    @ViewBuilder
    var passwordInputField: some View {
        let placeholder = Text("******").style(
            size: 17,
            weight: .regular,
            color: Constants.textPlaceholder
        )

        if state.hasHiddenInput {
            SecureField(text: $state.passwordInput) {
                placeholder
            }
            .font(.system(size: 17, weight: .regular))
        } else {
            TextField(text: $state.passwordInput) {
                placeholder
            }
            .font(.system(size: 17, weight: .regular))
        }
    }

    var fieldOverlay: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(lineWidth: 1)
            .fill(Constants.strokeColor)
    }

    func inputView(placeholder: String, text: Binding<String>) -> some View {
        TextField(text: text) {
            Text(placeholder)
                .style(size: 17, weight: .regular, color: Constants.textPlaceholder)
        }
        .padding(12)
        .overlay {
            fieldOverlay
        }
    }

    func titleView(title: String) -> some View {
        Text(title)
            .style(size: 13, weight: .semibold, color: Constants.textPrimary)
    }

    func closeButton() -> some View {
        Button {
            output.onTapCloseButton()
        } label: {
            DLIcon.close.image
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
    }
}

// MARK: - Constants

private extension LoginScreenView {

    enum Constants {
        
        static let textDarkBlue = DLColor<TextPalette>.darkBlue.color
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let textPlaceholder = DLColor<TextPalette>.placeholder.color
        static let strokeColor = DLColor<SeparatorPalette>.gray.color
    }
}
