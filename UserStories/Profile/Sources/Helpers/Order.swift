//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

struct Order: Identifiable, Hashable {

    let id: Int
    let formattedTotalPrice: String
    let createdAt: String
    let totalCashback: String
    let payment: String
}
