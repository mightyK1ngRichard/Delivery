//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Coordinator
import SharedUserStories

public enum ProfileRoute: Hashable, Identifiable, Sendable, RouteConvertible {

    case main
    case authFlow
    case userData
    case addressFlow(AddressRoute)
//    case productDetails(Product)
//    case orderDetails(orderID: Int)
    case orders

    public var id: Self { self }
}

extension ProfileRoute {

    public static func convert<ChildRoute>(from route: ChildRoute) -> ProfileRoute? where ChildRoute: Hashable {
        if let route = route as? AddressRoute {
            return .addressFlow(route)
        }

        return nil
    }
}
