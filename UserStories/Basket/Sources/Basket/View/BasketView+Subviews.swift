//
//  Created by Dmitriy Permyakov on 09.07.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DesignSystem
import DLCore
import SharedUserStories

extension BasketScreenView {

    var mainContainer: some View {
        Group {
            switch state.screenState {
            case .loading:
                loaderView
            case .content:
                emptyOrContentView
            case .error:
                ErrorView(title: "Ошибка получения данных") {
                    output.onTapReloadButton()
                }
            }
        }
        .navigationTitle(Constants.navigationTitle.capitalized)
    }
}

// MARK: - UI Subviews

private extension BasketScreenView {

    @ViewBuilder
    var emptyOrContentView: some View {
        if state.products.isEmpty {
            notificationsView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    basketIsEmptyView
                }
        } else {
            mainBlockContainer
        }
    }

    var loaderView: some View {
        VStack(spacing: .SPx3) {
            ForEach(0..<3, id: \.self) { _ in
                ShimmeringView()
                    .frame(height: 174)
                    .clipShape(.rect(cornerRadius: 20))
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, .SPx4)
    }

    var mainBlockContainer: some View {
        ScrollView {
            VStack(spacing: 0) {
                notificationsView

                switch state.screenState {
                case .loading:
                    loaderView.padding(.top)
                case .content:
                    productCardsView.padding(.top)
                case .error:
                    ErrorView(title: "Ошибка получения данных")
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 150)
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .bottom) {
            overlayView
        }
    }

    var notificationsView: some View {
        VStack {
            ForEach(state.notifications) { notification in
                DLNotification(text: notification.title)
            }
        }
        .padding(.horizontal)
    }

    var productCardsView: some View {
        VStack(spacing: 12) {
            ForEach(state.products) { product in
                DLProductHCard(
                    configuration: state.factory.convertToProductHCard(from: product),
                    handlerConfiguration: productHandler(product: product)
                )
                .frame(height: 174)
                .contentShape(.rect)
                .onTapGesture {
                    output.onTapProduct(product: product)
                }
            }
        }
    }

    var basketIsEmptyView: some View {
        DontResultView(
            configuration: .init(
                resourceName: "cryingEmoji",
                title: Constants.placeholderText.title,
                subtitle: Constants.placeholderText.subtitle
            )
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            DLBasketMakeOrderButton(
                configuration: .init(
                    state: .default,
                    title: Constants.openCatalogButtonText.title,
                    subtitle: Constants.openCatalogButtonText.subtitle,
                    isDisable: false
                ),
                didTapButton: {
                    output.onTapOpenCatalog()
                }
            )
            .buttonShadow
            .padding(.horizontal, 12)
            .padding(.bottom)
        }
        .navigationTitle(Constants.navigationTitle.capitalized)
    }

    var overlayView: some View {
        DLMinimumOrderSumView(
            needPrice: state.amountInfo.needPriceTitle,
            total: state.amountInfo.resultSumTitle,
            isReady: state.amountInfo.isReady ,
            minimumSum: state.amountInfo.minPriceTitle,
            isOpened: $state.isOpenedSheet,
            didTapMakeOrderButton: {
                output.onTapMakeOrderButton()
            }
        )
        .buttonShadow
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - Helpers

private extension View {

    var buttonShadow: some View {
        clipShape(.rect).shadow(
            color: DLColor<ShadowPalette>.dark.color,
            radius: 16,
            x: 0,
            y: -4
        )
    }
}

// MARK: - DLProductHCard HandlerConfiguration

private extension BasketScreenView {

    func productHandler(product: ProductModel) -> DLProductHCard.HandlerConfiguration {
        .init(
            didTapPlus: { counter in
                output.onTapPlus(product: product, counter: counter)
            },
            didTapMinus: { counter in
                output.onTapMinus(product: product, counter: counter)
            },
            didTapLike: { isSelected in
                output.onTapLike(productID: product.id, isSelected: isSelected)
            },
            didTapDelete: { counter in
                output.onTapDelete(productID: product.id)
            }
        )
    }
}

// MARK: - Constants

private extension BasketScreenView {

    enum Constants {

        static let navigationTitle = "Корзина"
        static let openCatalogButtonText = (
            title: String(localized: "В каталог"),
            subtitle: String(localized: "К поиску более 1 млн товаров")
        )
        static let placeholderText = (
            title: String(localized: "Корзина пуста"),
            subtitle: String(localized: "Мотивирующий текст")
        )
    }
}
