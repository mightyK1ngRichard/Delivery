//
//  Created by Dmitriy Permyakov on 08.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

protocol AnyProductDetailsScreenFactory {
    func makeBasketButtonTitle(from model: Product) -> String
}
