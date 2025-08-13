//
//  Created by Dmitriy Permyakov on 11.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import DLNetwork
import DLCore
import UserServiceInterface
import SharedContractsInterface
import OrderServiceInterface

struct BootIteractor: AnyBootIteractor {

    let networkStore: AnyNetworkStore
    let sessionStore: AnySessionStore

    let userService: AnyUserService
    let orderService: AnyOrderService

    private let logger = DLLogger("Boot Iteractor")

    func initialize() async -> Bool {
        logger.info("Проверка токена")
        let isExist = await networkStore.token != nil
        logger.info("Существует токен: \(isExist)")
        return isExist
    }

    func fetchInitialData() async -> [ProductEntity] {
        async let addressFetching: () = fetchUserAddresses()
        async let userFetching: () = fetchUserData()
        async let basketFetching = fetchBasket()

        let (_, _, products) = await (addressFetching, userFetching, basketFetching)
        return products
    }

    private func fetchUserAddresses() async {
        // Если нет адреса, то получаем список адресов
        if await networkStore.addressID == nil {
            logger.info("Данные адреса не найдены, получаем список адресов")
            do {
                let _ = try await orderService.forceFetchUserAddresses()
                logger.info("Данные адресов получены успешно")
            } catch {
                logger.error("Ошибка получения списка адресов: \(error.localizedDescription)")
            }
        }

        logger.info("Запоминаем наличие адреса для доставки")
        let hasAddress = await networkStore.addressID != nil
        await sessionStore.setHasAddressDelivery(hasAddress)
    }

    private func fetchBasket() async -> [ProductEntity] {
        do {
            logger.info("Начало получения данных корзины")
            let products = try await userService.forceFetchBasketProducts()
            logger.info("Данные корзины получены успешно")
            return products
        } catch {
            logger.error("Ошибка получения данных корзины: \(error.localizedDescription)")
            return []
        }
    }

    private func fetchUserData() async {
        do {
            logger.info("Запрашиваем данные пользователя")
            let user = try await userService.userData()
            logger.info("Данные пользователя получены успешно")
            if user.verifyFlagEmail == 0 {
                await sessionStore.setUserEmailCheched()
            }
            if user.verifyFlagPhone == 0 {
                await sessionStore.setUserEmailCheched()
            }
            if let balance = Double(user.balance ?? "") {
                await sessionStore.updateUserBalance(balance)
            }
        } catch {
            logger.error("Ошибка полученния данных пользователя: \(error.localizedDescription)")
        }
    }
}
