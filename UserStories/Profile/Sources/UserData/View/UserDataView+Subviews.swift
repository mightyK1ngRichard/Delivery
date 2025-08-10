//
//  Created by Dmitriy Permyakov on 05.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DesignSystem

extension UserDataView {

    var mainContainer: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                switch state.screenState {
                case .loading:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .content:
                    mainInfoBlock
                    userDataSection
                        .padding(.bottom, 100)
                case .error:
                    ErrorView(title: "Ошибка получения данных", handler: output.onTapReloadData)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Constants.navigationTitle)
        .overlay(alignment: .bottom) {
            saveButton
        }
    }
}

// MARK: - UI Subviews

private extension UserDataView {

    func sectionTitle(_ title: String) -> some View {
        Text(title)
            .style(size: 22, weight: .bold, color: Constants.primaryColor)
            .padding(.bottom, 8)
            .padding(.top)
    }

    var mainInfoBlock: some View {
        VStack(alignment: .leading, spacing: 0) {
            sectionTitle("Основная информация ")

            VStack(spacing: 16) {
                emailBlock
                phoneBlock
            }
        }
    }

    var emailBlock: some View {
        VStack(spacing: 24) {
            emailHeaderView
            emailFooterView
        }
        .padding([.horizontal, .top])
        .padding(.bottom, 24)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .fill(DLColor<SeparatorPalette>.orange.color)
        }
    }

    var emailHeaderView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.emailTitle)
                .style(size: 13, weight: .semibold, color: Constants.primaryColor)

            TextField(text: $state.emailInput) {
                Text("joedoe@gmail.com")
            }
            .padding(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(Constants.seaparatorColor)
            }

            Button {
                output.onTapRequestCodeForEmail()
            } label: {
                Text("Запросить код")
                    .style(size: 13, weight: .regular, color: Constants.blueTextColor)
            }
        }
    }

    var emailFooterView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                TextField(text: $state.confirmationEmailСodeInput) {
                    Text("******")
                }
                .padding(.leading, 12)

                Button {
                    output.onTapConfirmEmailCode()
                } label: {
                    Text(Constants.confirmTitle)
                        .style(size: 13, weight: .medium, color: Constants.secondaryColor)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 10)
                }
                .disabled(!state.codeForEmailDidEntered)
                .background(
                    state.codeForEmailDidEntered
                        ? Constants.primaryBgColor
                        : Constants.secondaryBgColor
                )
            }
            .clipShape(.rect(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(Constants.seaparatorColor)
            }

            Text("Введите код, полученный при регистрации, или перейдите поссылке из письма")
                .style(size: 13, weight: .regular, color: Constants.gray800Color)
                .padding(.top, 8)
        }
    }

    var phoneBlock: some View {
        VStack(alignment: .leading, spacing: 23) {
            phoneHeaderView
            phoneFooterView
        }
        .padding([.horizontal, .top])
        .padding(.bottom, 24)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .fill(Constants.seaparatorGreenColor)
        }
    }

    var phoneHeaderView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Телефон")
                .style(size: 13, weight: .semibold, color: Constants.primaryColor)

            TextField(text: $state.phoneInput) {
                Text("+7")
            }
            .padding(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(Constants.seaparatorColor)
            }

            HStack {
                Button {
                    output.onTapGetCall()
                } label: {
                    Text("Получить звонок")
                        .style(size: 13, weight: .regular, color: Constants.blueTextColor)
                }

                Spacer()

                Button {
                    output.onTapRequestCodeForPhone()
                } label: {
                    Text("Запросить код")
                        .style(size: 13, weight: .regular, color: Constants.blueTextColor)
                }
            }
        }
    }

    var phoneFooterView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                TextField(text: $state.confirmationPhoneСodeInput) {
                    Text("******")
                }
                .padding(.horizontal, 12)

                Button {
                    output.onTapConfirmPhoneCode()
                } label: {
                    Text(Constants.confirmTitle)
                        .style(size: 13, weight: .medium, color: Constants.secondaryColor)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 10)
                }
                .disabled(!state.codeForPhoneDidEntered)
                .background(
                    state.codeForPhoneDidEntered
                        ? Constants.primaryBgColor
                        : Constants.secondaryBgColor
                )
            }
            .clipShape(.rect(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(Constants.seaparatorColor)
            }

            Text("На номер телефона +7(906)714-73-10 поступит звонок. Для подтверждения телефона введите последние 4 цифры входящего номера телефона")
                .style(size: 13, weight: .regular, color: Constants.gray800Color)
        }
    }

    var userDataSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionTitle("Ваши данные")
            userDataRows
        }
    }

    var userDataRows: some View {
        VStack(alignment: .leading, spacing: 24) {
            userDataRow(
                title: "Наименование организации",
                inputText: $state.companyNameInput,
                placeholder: "Имя"
            )
            userDataRow(
                title: "Инн",
                inputText: $state.innInput,
                placeholder: "707313761063"
            )
            userDataRow(
                title: "КПП",
                inputText: $state.kppInput,
                placeholder: "272-04-042-4"
            )
        }
    }

    func userDataRow(
        title: String,
        inputText: Binding<String>,
        placeholder: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .style(size: 13, weight: .semibold, color: Constants.primaryColor)

            HStack(spacing: 8) {
                TextField(placeholder, text: inputText)

                DLIcon.bottomChevron.image
                    .frame(width: 20, height: 20)
            }
            .padding(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .fill(Constants.separatorGrayColor)
            }
        }
    }

    var saveButton: some View {
        Button {
            output.onTapSaveButton()
        } label: {
            Text("Сохранить")
                .style(size: 16, weight: .semibold, color: Constants.whiteTextColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 22)
        }
        .background(Constants.primaryBgColor, in: .rect(cornerRadius: 12))
        .padding(16)
    }
}

// MARK: - Constants

private extension UserDataView {

    enum Constants {
        static let confirmTitle = String(localized: "Подтвердить")
        static let navigationTitle = String(localized: "Мои данные")
        static let emailTitle = String(localized: "E-mail")
        static let whiteTextColor = DLColor<TextPalette>.white.color
        static let primaryColor = DLColor<TextPalette>.primary.color
        static let secondaryColor = DLColor<TextPalette>.gray300.color
        static let secondaryBgColor = DLColor<BackgroundPalette>.gray300.color
        static let primaryBgColor = DLColor<BackgroundPalette>.blue.color
        static let gray800Color = DLColor<TextPalette>.gray800.color
        static let blueTextColor = DLColor<TextPalette>.blue.color
        static let separatorGrayColor = DLColor<SeparatorPalette>.gray.color
        static let seaparatorColor = DLColor<SeparatorPalette>.gray300.color
        static let seaparatorGreenColor = DLColor<SeparatorPalette>.green.color
    }
}
