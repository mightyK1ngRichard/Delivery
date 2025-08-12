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
        do {
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

            logger.info("Начало получения данных корзины")
            let products = try await userService.forceFetchBasketProducts()
            logger.info("Данные корзины получены успешно")
            return products
        } catch {
            logger.error("Ошибка получения данных корзины: \(error.localizedDescription)")
            return []
        }
    }
}
