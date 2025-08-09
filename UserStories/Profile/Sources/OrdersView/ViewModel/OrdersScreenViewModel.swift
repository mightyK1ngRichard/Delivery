//
//  Created by Dmitriy Permyakov on 06.09.2024.
//  Copyright 2024 © Dostavka24 LLC. All rights reserved.
//

import Foundation
import DLCore

final class OrdersScreenViewModel {

    private let state: OrdersViewState
    private let networkClient: AnyOrdersScreenNetworkClient
    private let factory: AnyOrdersScreenFactory
    private weak var output: OrdersScreenOutput?

    private let logger = DLLogger("Orders Screen View Model")

    init(
        state: OrdersViewState,
        factory: AnyOrdersScreenFactory,
        networkClient: AnyOrdersScreenNetworkClient,
        output: OrdersScreenOutput
    ) {
        self.state = state
        self.factory = factory
        self.networkClient = networkClient
        self.output = output
    }
}

// MARK: - OrdersViewOutput

extension OrdersScreenViewModel: OrdersViewOutput {

    func onFirstAppear() {
        logger.logEvent()
        fetchData()
    }

    func onTapReloadButton() {
        logger.logEvent()
        fetchData()
    }

    func onTapOrderInfo(orderID: Int) {
        logger.logEvent()
        output?.openOrderDetails(orderID: orderID)
    }

    func onTapReloadOrder(orderID: Int) {
        logger.logEvent()
    }
}

// MARK: - Helpers

private extension OrdersScreenViewModel {

    @MainActor
    func fetchData() {
        state.screenState = .loading

        Task {
            do {
                let orders = try await networkClient.forceFetchOrders()
                state.orders = orders.compactMap(factory.convertToOrder)
                state.screenState = .content
            } catch {
                logger.error(error)
                state.screenState = .error
            }
        }
    }
}
