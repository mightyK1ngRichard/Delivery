//
//  Created by Dmitriy Permyakov on 06.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import SwiftUI
import DesignSystem

struct OrdersScreenView: View {

    @ObservedObject
    var state: OrdersViewState
    let output: OrdersViewOutput

    var body: some View {
        mainContainer.onFirstAppear {
            output.onFirstAppear()
        }
    }
}

// MARK: - UI Subviews

private extension OrdersScreenView {

    @ViewBuilder
    private var mainContainer: some View {
        switch state.screenState {
        case .loading:
            shimmeringContainer
        case .error:
            ErrorView(title: "Ошибка получения данных", handler: output.onTapReloadButton)
        case .content:
            content
        }
    }

    var content: some View {
        ScrollView {
            VStack {
                ForEach(state.orders) { order in
                    orderCellView(order: order)
                }
            }
        }
        .navigationTitle(Constants.navigationTitle)
        .searchable(
            text: $state.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Поиск"
        )
    }

    var shimmeringContainer: some View {
        VStack {
            ForEach(0..<3, id: \.self) { _ in
                ShimmeringView()
                    .frame(height: 174)
                    .clipShape(.rect(cornerRadius: 20))
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    func orderCellView(order: Order) -> some View {
        DLOrderInfoCell(
            configuration: state.factory.converToOrderCell(from: order),
            handlerConfigurations: .init(
                didTapInfo: {
                    output.onTapOrderInfo(orderID: order.id)
                },
                didTapReload: {
                    output.onTapReloadOrder(orderID: order.id)
                }
            )
        )
        .padding(.horizontal)
    }
}

// MARK: - Constants

private extension OrdersScreenView {

    enum Constants {

        static let textPrimary = DLColor<TextPalette>.primary.color
        static let navigationTitle = String(localized: "Заказы")
    }
}
