//
//  Created by Dmitriy Permyakov on 11.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import DLNetwork
import DLCore

struct AuthSessionInteractor: AnyAuthSessionInteractor {

    let networkStore: AnyNetworkStore
    let sessionStore: AnySessionStore

    private let logger = DLLogger("Auth Session Interactor")

    func stopSession() async {
        logger.info("Начало сброса сессионных данных")
        await networkStore.setToken(nil)
        await networkStore.setAddressID(nil)
        await sessionStore.clearAll()
        // TODO: [Cachable].clearStorage()
        logger.info("Данные сброшены")
    }
}
