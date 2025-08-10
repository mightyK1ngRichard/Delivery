//
//  Created by Dmitriy Permyakov on 30.06.2025
//  Copyright © 2025 Dostavka24. All rights reserved.
//

import Coordinator

enum ProfileRoute: Hashable, Identifiable, RouteConvertible {

    case main
//    case signIn
//    case signUp
    case userData
    case addressFlow(AddressRoute)
//    case productDetails(Product)
//    case orderDetails(orderID: Int)
    case orders

    var id: Self { self }
}

extension ProfileRoute {

    static func convert<ChildRoute>(from route: ChildRoute) -> ProfileRoute? where ChildRoute: Hashable {
        if let route = route as? AddressRoute {
            return .addressFlow(route)
        }

        return nil
    }
}
