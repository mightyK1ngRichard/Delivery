//
//  Created by Dmitriy Permyakov on 13.06.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DesignSystem

struct Product: Identifiable {

    let id: Int
    let imageURL: String
    let title: String
    let price: String
    let description: String
    let startCounter: Int
    let magnifier: Int
    let tags: [ProductSection]
}
