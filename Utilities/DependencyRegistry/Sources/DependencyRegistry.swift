//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import Resolver
import DLNetwork
import AuthServiceInterface
import AuthService
import BannerServiceInterface
import BannerService
import CartServiceInterface
import CartService
import OrderServiceInterface
import OrderService
import PopcatsServiceInterface
import PopcatsService
import ProductServiceInterface
import ProductService
import UserServiceInterface
import UserService

extension Resolver {

    public static func registerAll() {
        registerUtilities()
        registerServices()
    }

    private static func registerServices() {
        let networkStore = Resolver.resolve(AnyNetworkStore.self)
        let networkClient = Resolver.resolve(AnyNetworkClient.self)

        Resolver.register(AnyAuthService.self) {
            AuthServiceImpl(networkStore: networkStore, networkClient: networkClient)
        }

        Resolver.register(AnyBannersService.self) {
            BannersServiceImpl(networkClient: networkClient)
        }

        Resolver.register(AnyCartService.self) {
            CartServiceImpl(networkClient: networkClient)
        }

        Resolver.register(AnyOrderService.self) {
            OrderServiceImpl(networkClient: networkClient)
        }

        Resolver.register(AnyPopcatsService.self) {
            PopcatsServiceImpl(networkClient: networkClient)
        }

        Resolver.register(AnyProductService.self) {
            ProductServiceImpl(networkClient: networkClient)
        }

        Resolver.register(AnyUserService.self) {
            UserServiceImpl(networkClient: networkClient)
        }
    }

    private static func registerUtilities() {
        Resolver.register(AnyNetworkStore.self) { NetworkStore() }
        Resolver.register(AnyServerHostProvider.self) { ServerHostProvider() }
        Resolver.register(AnyNetworkClient.self) {
            let serverHostProvider = Resolver.resolve(AnyServerHostProvider.self)
            let networkStore = Resolver.resolve(AnyNetworkStore.self)
            return NetworkClient(hostProvider: serverHostProvider, networkStore: networkStore)
        }
    }
}
