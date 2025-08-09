//
//  Created by Dmitriy Permyakov on 03.08.2025.
//  Copyright © 2025 https://github.com/mightyK1ngRichard. All rights reserved.
//

public protocol RouteConvertible: Hashable {
    static func convert<ChildRoute: Hashable>(from route: ChildRoute) -> Self?
}

public final class ProxyRouter<ParentRoute: Hashable & RouteConvertible & Sendable, ChildRoute: Hashable & Sendable>: Router<ChildRoute>, @unchecked Sendable {
    private let parentRouter: Router<ParentRoute>

    public init(parentRouter: Router<ParentRoute>) {
        self.parentRouter = parentRouter
        super.init(navPath: parentRouter.navPath)
    }

    public override func push(_ route: ChildRoute) {
        guard let convertedRoute = ParentRoute.convert(from: route) else {
            fatalError("imposible to convert route \(route) to parent route")
        }

        parentRouter.push(convertedRoute)
    }

    public override func pop(count: Int = 1) {
        parentRouter.pop(count: count)
    }

    public override func removeAll() {
        parentRouter.removeAll()
    }

    public override func present(_ route: ChildRoute, completion: (() -> Void)? = nil) {
        guard let convertedRoute = ParentRoute.convert(from: route) else {
            fatalError("imposible to convert route \(route) to parent route")
        }

        parentRouter.present(convertedRoute, completion: completion)
    }

    public override func fullScreenCover(_ route: ChildRoute, completion: (() -> Void)? = nil) {
        guard let convertedRoute = ParentRoute.convert(from: route) else {
            fatalError("imposible to convert route \(route) to parent route")
        }

        parentRouter.fullScreenCover(convertedRoute, completion: completion)
    }

    public override func dismiss() {
        parentRouter.dismiss()
    }
}
