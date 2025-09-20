//
//  Created by Dmitriy Permyakov on 11.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import DLNetwork
import DLCore
import UserServiceInterface
import SharedContractsInterface
import OrderServiceInterface
import CartServiceInterface

struct BootIteractor: AnyBootIteractor {

    let networkStore: AnyNetworkStore
    let userService: AnyUserService
    let orderService: AnyOrderService
    let cartService: AnyCartService

    private let logger = DLLogger("Boot Iteractor")

    func initialize() async -> Bool {
        logger.info("Проверка токена")
        let isExist = await networkStore.token != nil
        logger.info("Существует токен: \(isExist)")
        return isExist
    }

    func fetchInitialData() async -> (Bool, [ProductEntity]) {
        let hasAddress = await fetchUserAddresses()

        async let userFetching: Void = fetchUserData()
        async let basketFetching = fetchBasket()

        let (_, products) = await (userFetching, basketFetching)
        return (hasAddress, products)
    }

    private func fetchUserAddresses() async -> Bool {
        let address = await networkStore.address
        // Если нет адреса, то получаем список адресов
        guard let address else {
            logger.info("Данные адреса не найдены, получаем список адресов")
            do {
                let addresses = try await orderService.forceFetchUserAddresses()
                if let addressTitle = await networkStore.address?.title {
                    userService.setAddressTitle(addressTitle)
                }
                
                logger.info("Данные адресов получены успешно")
                return !addresses.isEmpty
            } catch {
                logger.error("Ошибка получения списка адресов: \(error.localizedDescription)")
                return false
            }
        }

        if let addressTitle = address.title {
            userService.setAddressTitle(addressTitle)
        }

        return true
    }

    private func fetchBasket() async -> [ProductEntity] {
        do {
            logger.info("Начало получения данных корзины")
            let products = try await userService.forceFetchBasketProducts()
            cartService.saveProductsBasket(products.compactMap {
                guard let id = $0.id, let count = $0.realCount else { return nil }
                return .init(id: id, count: count)
            })
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
            let _ = try await userService.userData()
            logger.info("Данные пользователя получены успешно")
        } catch {
            logger.error("Ошибка полученния данных пользователя: \(error.localizedDescription)")
        }
    }
}
