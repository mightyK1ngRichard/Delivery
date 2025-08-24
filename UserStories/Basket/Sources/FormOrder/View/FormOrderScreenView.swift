//
//  Created by Dmitriy Permyakov on 12.07.2025.
//  Copyright © 2025 Dostavka24 LLC. All rights reserved.
//

import SwiftUI
import DesignSystem

struct FormOrderScreenView: View {

    @StateObject
    var state: FormOrderScreenViewState
    let output: FormOrderScreenViewOutput

    var body: some View {
        mainContainer
            .fullScreenCover(isPresented: $state.showSuccessView) {
                FormOrderSuccessView(action: output.onTapOpenCatalogScreen)
            }
    }
}

// MARK: - UI Subviews

private extension FormOrderScreenView {

    var mainContainer: some View {
        ScrollView {
            VStack {
                imagesContainer
                optionsContainer
            }
        }
        .navigationTitle(Constants.navigationTitle)
        .alert(state.alertModel, showAlert: $state.showAlert)
        .overlay(alignment: .bottom) {
            overlayButton
        }
    }

    var imagesContainer: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(state.deliveryDate)
                .style(size: 13, weight: .regular, color: Constants.textSecondary)
                .padding(.leading)

            DLProductsCarousel(
                configuration: state.convertToProductCarouselConfiguration(),
                handlerConfiguration: .init(
                    onTapTitle: output.onTapOpenProductsList,
                    onTapImage: output.onTapProduct
                )
            )
        }
    }

    var optionsContainer: some View {
        VStack {
            paymentMethodView
            bonusPaymentView
            resultView
        }
        .padding(.horizontal)
    }

    var paymentMethodView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(Constants.paymentMethodTitle)
                .style(size: 17, weight: .semibold, color: Constants.textPrimary)

            HStack {
                Text(state.selectedPaymentKind.localized)
                Spacer()
                DLIcon.chivronBottom.image
                    .frame(width: 20, height: 20)
            }
            .padding([.vertical, .horizontal], 12)
            .background(Constants.bgWhite, in: .rect(cornerRadius: 12))
            .contentShape(.rect)
            .onTapGesture {
                output.onTapChoosePaymentType()
            }
        }
        .padding()
        .background(Constants.bgGray, in: .rect(cornerRadius: 16))
    }

    var bonusPaymentView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(Constants.bonusPaymenTitle)
                        .style(size: 17, weight: .semibold, color: Constants.textPrimary)

                    Text(Constants.paymentMethodSubtitle)
                        .style(size: 13, weight: .regular, color: Constants.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .layoutPriority(1)

                Toggle(isOn: $state.bonusesIncluded) {}
                    .labelsHidden()
            }

            if state.bonusesIncluded {
                HStack {
                    TextField("0", text: $state.inputBonusesCount)
                        .textFieldStyle(.plain)
                        .keyboardType(.numberPad)

                    Button(action: output.onTapApplyBonuses, label: {
                        Text("Применить")
                            .style(size: 13, weight: .semibold, color: Constants.textDarkBlue)
                    })
                }
                .padding(12)
                .background(.white, in: .rect(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1)
                        .fill(DLColor<SeparatorPalette>.gray.color)
                }
            }
        }
        .padding()
        .background(Constants.bgGray, in: .rect(cornerRadius: 16))
    }

    var resultView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let cashback = state.cashback {
                HStack {
                    Text(Constants.сashbackTitle)
                        .style(size: 13, weight: .regular, color: Constants.textPrimary)
                    Spacer()
                    Text(cashback)
                        .style(size: 14, weight: .semibold, color: Constants.textPrimary)
                }
            }

            if let bonuses = state.bonusesCount, state.bonusesIncluded {
                HStack {
                    Text(Constants.bonusesTitle)
                        .style(size: 13, weight: .regular, color: Constants.textPrimary)
                    Spacer()
                    Text(String(bonuses))
                        .style(size: 14, weight: .semibold, color: Constants.textPrimary)
                }
            }

            HStack {
                Text(Constants.deliveryTitle)
                    .style(size: 13, weight: .regular, color: Constants.textPrimary)
                Spacer()
                Text(state.deliveryPrice)
                    .style(size: 14, weight: .semibold, color: Constants.textSuccess)
            }

            HStack {
                Text("Итого")
                    .style(size: 22, weight: .bold, color: Constants.textPrimary)
                Spacer()
                Text(state.resultSum)
                    .style(size: 22, weight: .bold, color: Constants.textPrimary)
            }
        }
        .padding()
        .background(Constants.bgGray, in: .rect(cornerRadius: 16))
        .padding(.bottom, 100)
    }

    var overlayButton: some View {
        DLBasketMakeOrderButton(
            configuration: .init(
                state: state.buttonState,
                title: Constants.makeOrderTitle,
                subtitle: "\(Constants.resultTitle) \(state.resultSum)",
                isDisable: false
            ),
            didTapButton: output.onTapMakeOrder
        )
        .padding(.horizontal, 12)
        .padding(.vertical)
    }
}

// MARK: - Constants

private extension FormOrderScreenView {

    enum Constants {
        static let navigationTitle = String(localized: "Оформление заказа")
        static let bonusPaymenTitle = String(localized: "Оплатить бонусами")
        static let paymentMethodTitle = String(localized: "Способ оплаты")
        static let paymentMethodSubtitle = String(localized: "Оплата бонусами возможна суммами кратным 100")
        static let сashbackTitle = String(localized: "Кэшбэк")
        static let bonusesTitle = String(localized: "Бонусы")
        static let deliveryTitle = String(localized: "Доставка")
        static let makeOrderTitle = String(localized: "Оформить заказ")
        static let resultTitle = String(localized: "Итого")

        static let textPrimary = DLColor<TextPalette>.primary.color
        static let textWhite = DLColor<TextPalette>.white.color
        static let textSecondary = DLColor<TextPalette>.gray800.color
        static let textDarkBlue = DLColor<TextPalette>.darkBlue.color
        static let textSuccess = DLColor<TextPalette>.success.color
        static let bgWhite = DLColor<BackgroundPalette>.white.color
        static let bgGray = DLColor<BackgroundPalette>.gray100.color
    }
}
