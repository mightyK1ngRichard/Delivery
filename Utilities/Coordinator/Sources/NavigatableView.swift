//
//  Created by Dmitriy Permyakov on 03.08.2025.
//  Copyright © 2025 https://github.com/mightyK1ngRichard. All rights reserved.
//

import SwiftUI

public struct NavigatableView<Route: Identifiable>: View where Route: Hashable {

    private let coordinator: any Navigatable

    @StateObject
    private var router: Router<Route>

    private let buildDestination: (Route) -> AnyView

    private let coordinatorContentWrapperBuilder: () -> CoordinatorContentWrapper<Route>

    public init<C: Navigatable>(_ coordinator: C) where C.Route == Route {
        self.coordinator = coordinator
        _router = StateObject(wrappedValue: coordinator.router)
        buildDestination = { route in
            AnyView(coordinator.destination(route))
        }
        coordinatorContentWrapperBuilder = { CoordinatorContentWrapper<Route>(coordinator) }
    }

    public var body: some View {
        NavigationStack(path: $router.navPath) {
            coordinatorContentWrapperBuilder()
                .equatable()
        }
        .sheet(
            item: $router.sheetItem,
            onDismiss: router.onDismissSheet,
            content: buildDestination
        )
        .fullScreenCover(
            item: $router.fullScreenCoverItem,
            onDismiss: router.onDismissFullScreenCover,
            content: buildDestination
        )
    }
}
