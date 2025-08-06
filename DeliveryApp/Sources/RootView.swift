//
//  Created by Dmitriy Permyakov on 06.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import CatalogService
import DLNetwork

@main
struct ContentView: App {

    let catalog = CatalogServiceImpl(
        networkClient: {
            NetworkClient(
                hostProvider: ServerHostProvider(),
                networkStore: NetworkStore()
            )
    }())

    var body: some Scene {
        WindowGroup {
            Button("Make request") {
                Task {
                    do {
                        let res = try await catalog.categories()
                        print("[DEBUG]: \(res)")
                    } catch {
                        print("[DEBUG]: \(error)")
                    }
                }
            }
        }
    }
}
