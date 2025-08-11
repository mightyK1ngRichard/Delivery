//
//  Created by Dmitriy Permyakov on 11.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import DLNetwork
import DLCore
import UserServiceInterface
import SharedContractsInterface

struct BootIteractor: AnyBootIteractor {

    let networkStore: AnyNetworkStore
    let userService: AnyUserService

    private let logger = DLLogger("Boot Iteractor")

    func initialize() async -> Bool {
        logger.info("Проверка токена")
        let isExist = await networkStore.token != nil
        logger.info("Существует токен: \(isExist)")
        return isExist
    }

    func fetchInitialData() async -> [ProductEntity] {
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
}
