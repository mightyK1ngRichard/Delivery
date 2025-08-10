//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

public enum AddressRoute: Identifiable, Hashable, Sendable {

    case addressesList
    case addAddress

    public var id: Self { self }
}
