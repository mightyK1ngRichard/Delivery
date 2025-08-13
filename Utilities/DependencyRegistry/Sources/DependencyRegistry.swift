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
import CatalogServiceInterface
import CatalogService
import MainInterface
import Main
import CatalogInterface
import Catalog
import ProfileInterface
import Profile
import BasketInterface
import Basket
import AuthInterface
import Auth

extension Resolver {

    @MainActor 
    public static func registerAll() {
        registerUtilities()
        registerServices()
        registerCoordinators()
    }

    @MainActor
    private static func registerCoordinators() {
        Resolver.register(AnyMainAssembly.self) { MainAssembly() }
        Resolver.register(AnyCatalogAssembly.self) { CatalogCoordinatorAssembly() }
        Resolver.register(AnyProfileAssembly.self) { ProfileAssembly() }
        Resolver.register(AnyBasketAssembly.self) { BasketAssembly() }
        Resolver.register(AnyAuthAssembly.self) { AuthAssembly() }
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
            OrderServiceImpl(networkClient: networkClient, networkStore: networkStore)
        }

        Resolver.register(AnyPopcatsService.self) {
            PopcatsServiceImpl(networkClient: networkClient)
        }

        Resolver.register(AnyProductService.self) {
            ProductServiceImpl(networkClient: networkClient)
        }

        Resolver.register(AnyUserService.self) {
            UserServiceImpl(networkClient: networkClient, networkStore: networkStore)
        }

        Resolver.register(AnyCategoryService.self) {
            CatalogServiceImpl(networkClient: networkClient)
        }
    }

    private static func registerUtilities() {
        Resolver.registerSingleton(AnyNetworkStore.self) { NetworkStore() }
        Resolver.register(AnyServerHostProvider.self) { ServerHostProvider() }
        Resolver.register(AnyNetworkClient.self) {
            let serverHostProvider = Resolver.resolve(AnyServerHostProvider.self)
            let networkStore = Resolver.resolve(AnyNetworkStore.self)
            return NetworkClient(hostProvider: serverHostProvider, networkStore: networkStore)
        }
    }
}
