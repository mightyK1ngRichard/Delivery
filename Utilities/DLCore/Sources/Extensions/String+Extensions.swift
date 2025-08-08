//
//  Created by Dmitriy Permyakov on 07.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation

extension String {

    public var capitalizingFirstLetter: String {
        prefix(1).capitalized + dropFirst()
    }
}
