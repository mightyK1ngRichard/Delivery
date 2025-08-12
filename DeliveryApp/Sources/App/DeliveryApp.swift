//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DependencyRegistry
import Resolver

@main
struct DeliveryApp: App {

    init() {
        Resolver.registerAll()
//        UserDefaults.standard.set("1uHxAyiRrMkxuUdV", forKey: "userToken")
//        UserDefaults.standard.set(1995, forKey: "addressID")
    }

    var body: some Scene {
        WindowGroup {
            RootAssembly.assemble()
        }
    }
}
