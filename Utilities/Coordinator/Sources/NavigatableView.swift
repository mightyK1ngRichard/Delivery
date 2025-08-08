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
            CoordinatorContentWrapper(coordinator)
                .equatable()
        }
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
    }
}

// MARK: - CoordinatorContentWrapper

struct CoordinatorContentWrapper<C: Navigatable>: View, Equatable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }

    private var coordinator: C

    init(_ coordinator: C) {
        self.coordinator = coordinator
    }

    var body: some View {
        coordinator.run()
            .navigationDestination(
                for: C.Route.self,
                destination: coordinator.destination
            )
    }
}
