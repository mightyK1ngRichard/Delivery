//
//  Created by Dmitriy Permyakov on 03.08.2025.
//  Copyright © 2025 https://github.com/mightyK1ngRichard. All rights reserved.
//

import SwiftUI

@MainActor
public protocol Navigatable: Sendable {
    associatedtype Route: Hashable & Identifiable & Sendable
    associatedtype Content: View
    associatedtype ContentDestination: View

    var router: Router<Route> { get }
    func run() -> Content
    func destination(_ route: Route) -> ContentDestination
}
