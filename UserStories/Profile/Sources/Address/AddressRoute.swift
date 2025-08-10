//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

enum AddressRoute: Identifiable, Hashable {

    case addressesList
    case addAddress

    var id: Self { self }
}
