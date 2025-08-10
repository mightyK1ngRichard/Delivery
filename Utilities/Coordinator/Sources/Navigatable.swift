//
//  Created by Dmitriy Permyakov on 03.08.2025.
//  Copyright © 2025 https://github.com/mightyK1ngRichard. All rights reserved.
//

import SwiftUI

@MainActor
public protocol Navigatable: AnyObject {

    associatedtype Content: View
    associatedtype ContentDestination: View
    associatedtype Route: Hashable, Identifiable

    @ViewBuilder
    func run() -> Self.Content
    @ViewBuilder
    func destination(_ route: Route) -> Self.ContentDestination

    var router: Router<Route> { get }
}
