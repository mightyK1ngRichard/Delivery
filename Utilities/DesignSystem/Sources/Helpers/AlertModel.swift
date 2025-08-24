//
//  Created by Dmitriy Permyakov on 23.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

public struct AlertModel: Hashable {

    public let title: String
    public let subtitle: String

    public init(
        title: String = String(),
        subtitle: String = String()
    ) {
        self.title = title
        self.subtitle = subtitle
    }
}
