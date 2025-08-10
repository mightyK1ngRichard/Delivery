//
//  Created by Dmitriy Permyakov on 10.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation

public struct AlertModel: Hashable {

    public let title: String
    public let subtitle: String
    public let buttonTitle: String?

    public init(
        title: String,
        subtitle: String,
        buttonTitle: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
    }
}
