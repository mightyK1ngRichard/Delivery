//
//  Created by Dmitriy Permyakov on 03.08.2025.
//  Copyright © 2025 https://github.com/mightyK1ngRichard. All rights reserved.
//

import SwiftUI

public struct NavigatableView<C: Navigatable>: View {

    @StateObject
    private var router: Router<C.Route>
    private let coordinator: C

    public init(coordinator: C) {
        _router = StateObject(wrappedValue: coordinator.router)
        self.coordinator = coordinator
    }

    public var body: some View {
        NavigationStack(path: $router.navPath) {
            coordinator.run()
                .sheet(
                    item: $router.sheetItem,
                    onDismiss: router.onDismissSheet,
                    content: coordinator.destination
                )
                .fullScreenCover(
                    item: $router.fullScreenCoverItem,
                    onDismiss: router.onDismissFullScreenCover,
                    content: coordinator.destination
                )
                .navigationDestination(for: C.Route.self) {
                    coordinator.destination($0)
                }
        }
    }
}
