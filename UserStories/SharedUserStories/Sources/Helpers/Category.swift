//
//  Created by Dmitriy Permyakov on 07.08.2025.
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DesignSystem

public struct Category: Identifiable, Sendable {

    public let id: Int
    public let imageURL: String
    public let title: String

    public init(id: Int, imageURL: String, title: String) {
        self.id = id
        self.imageURL = imageURL
        self.title = title
    }
}
