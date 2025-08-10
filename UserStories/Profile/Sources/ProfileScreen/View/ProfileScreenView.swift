//
//  Created by Dmitriy Permyakov on 05.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DLCore
import DesignSystem
import SharedUserStories

struct ProfileScreenView: View {

    @StateObject
    var state: ProfileScreenViewState
    let output: ProfileScreenViewOuput

    var body: some View {
        mainContainer.onFirstAppear {
            output.onFirstAppear()
        }
    }
}

extension ProfileScreenView {

    @ViewBuilder
    private var mainContainer: some View {
        switch state.screenKind {
        case .needAuth:
            needAuthContainerView
        case let .screenState(screenState):
            stateView(screenState: screenState)
        }
    }
}

// MARK: - UI Subviews

private extension ProfileScreenView {

    @ViewBuilder
    func stateView(screenState: ScreenState) -> some View {
        switch screenState {
        case .loading:
            ProgressView()
        case .error:
            ErrorView(title: "Ошибка", handler: output.onTapReloadData)
            rowInfo(row: .quit) {
                output.onTapMenuCell(.quit)
            }
        case .content:
            userIsAuthedView
        }
    }

    var needAuthContainerView: some View {
        DontResultView(
            configuration: .init(
                resourceName: Constants.emptyImage,
                title: Constants.emptyViewTitle,
                subtitle: Constants.emptyViewSubtitle
            )
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            VStack(spacing: 0) {
                DLButton(
                    configuration: .init(
                        hasDisabled: true,
                        titleView: {
                            Text("Регистарция")
                                .style(size: 16, weight: .semibold, color: DLColor<TextPalette>.white.color)
                        },
                        subtileView: { EmptyView() }
                    ),
                    action: {
                        output.onTapRegistrationButton()
                    }
                )
                .padding(.top, 81)
                .padding(.horizontal)

                HStack(spacing: 3) {
                    Text("Уже есть аккаунт?")
                        .style(size: 13, weight: .regular, color: Constants.textColor)

                    Button {
                        output.onTapSignInButton()
                    } label: {
                        Text("Войти")
                            .style(size: 13, weight: .regular, color: Constants.textBlue)
                    }

                }
                .padding(.top, 32)
            }
            .padding(.bottom, 60)
        }
    }

    var userIsAuthedView: some View {
        ScrollView {
            VStack(spacing: 16) {
                notificationBlock
                sectionsBlock
            }
        }
        .navigationTitle(Constants.navigationTitle)
    }

    var notificationBlock: some View {
        VStack {
            ForEach(state.notifications) { notification in
                DLNotification(text: notification.title)
                    .padding(.horizontal)
            }
        }
    }

    var sectionsBlock: some View {
        VStack(spacing: 0) {
            ForEach(state.menuCells) { cell in
                rowInfo(row: cell) {
                    output.onTapMenuCell(cell)
                }
                .overlay(alignment: .bottom) {
                    Divider().padding(.leading)
                }
            }
        }
    }

    @ViewBuilder
    func rowInfo(
        row: ProfileScreenViewState.MenuCell,
        didTapRowTitle: @escaping DLVoidBlock
    ) -> some View {
        switch row {
        case .favorites:
            favoriteRowView(
                title: row.locolizedString,
                iconResource: row.iconRosource,
                didTapTitle: didTapRowTitle
            ) { product in
                output.onTapProduct(product: product)
            }
        case .userData, .address, .orders,
                .telegramBot, .info, .feedback:
            rowTitleView(
                title: row.locolizedString,
                iconResource: row.iconRosource,
                didTapRowTitle: didTapRowTitle
            )
            .padding(.horizontal)
        case .faq, .quit:
            rowTitleView(
                title: row.locolizedString,
                iconResource: row.iconRosource,
                didTapRowTitle: didTapRowTitle
            )
            .padding(.horizontal)
            .padding(.top, 32)
        }
    }

    func rowTitleView(
        title: String,
        iconResource: String,
        didTapRowTitle: @escaping DLVoidBlock
    ) -> some View {
        HStack(spacing: 0) {
            DLIcon.image(resource: iconResource)
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundStyle(Constants.iconColor)

            Text(title.capitalizingFirstLetter)
                .style(size: 17, weight: .regular, color: Constants.textColor)
                .padding(.leading, 8)

            Spacer()

            DLIcon.chivronRight.image
                .renderingMode(.template)
                .frame(width: 44, height: 44)
                .foregroundStyle(Constants.iconSecondaryColor)
        }
        .contentShape(.rect)
        .onTapGesture {
            didTapRowTitle()
        }
    }

    func favoriteRowView(
        title: String,
        iconResource: String,
        didTapTitle: @escaping DLVoidBlock,
        didTapProduct: @escaping DLGenericBlock<ProductModel>
    ) -> some View {
        VStack(spacing: 0) {
            rowTitleView(
                title: title,
                iconResource: iconResource,
                didTapRowTitle: didTapTitle
            )
            .padding(.horizontal)

            if !state.favoriteProducts.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: .SPx2) {
                        ForEach(state.favoriteProducts) { product in
                            productImage(product: product)
                                .onTapGesture {
                                    didTapProduct(product)
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
    }

    func productImage(product: ProductModel) -> some View {
        DLImageView(configuration: .init(
            imageKind: .url(product.imageURL),
            contentMode: .fit
        ))
        .frame(width: 75, height: 100)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 20))
    }
}

// MARK: - Constants

private extension ProfileScreenView {

    enum Constants {
        static let textColor = DLColor<TextPalette>.primary.color
        static let textBlue = DLColor<TextPalette>.darkBlue.color
        static let iconColor = DLColor<IconPalette>.gray800.color
        static let iconSecondaryColor = DLColor<IconPalette>(
            hexLight: 0x3C3C434D,
            hexDark: 0x3C3C434D,
            alpha: 0.3
        ).color
        static let navigationTitle = String(localized: "Профиль")
        static let emptyImage = "profile"
        static let emptyViewTitle = "Здесь будут все данные о ваших заказах"
        static let emptyViewSubtitle = "Мотивирующий текст"
    }
}
