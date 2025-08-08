//
//  Created by Dmitriy Permyakov on 03.08.2025.
//  Copyright © 2025 https://github.com/mightyK1ngRichard. All rights reserved.
//

import SwiftUI

@MainActor
public class Router<Route: Hashable & Sendable>: ObservableObject, Sendable {

    @Published
    var navPath: NavigationPath

    @Published
    var sheetItem: Route?
    var onDismissSheet: (@MainActor () -> Void)?

    @Published
    var fullScreenCoverItem: Route?
    var onDismissFullScreenCover: (@MainActor () -> Void)?

    public init(navPath: NavigationPath = .init()) {
        self.navPath = navPath
    }

    // MARK: Navigation

    public func push(_ route: Route) {
        navPath.append(route)
    }

    public func pop(count: Int = 1) {
        navPath.removeLast(count)
    }

    public func removeAll() {
        navPath = .init()
    }

    // MARK: Presentation

    public func present(
        _ route: Route,
        @_implicitSelfCapture completion: (() -> Void)? = nil
    ) {
        onDismissSheet = completion
        sheetItem = route
    }

    public func fullScreenCover(
        _ route: Route,
        @_implicitSelfCapture completion: (() -> Void)? = nil
    ) {
        onDismissFullScreenCover = completion
        fullScreenCoverItem = route
    }

    public func dismiss() {
        onDismissSheet = nil
        onDismissFullScreenCover = nil
        sheetItem = nil
        fullScreenCoverItem = nil
    }
}
