//
//  Created by Dmitriy Permyakov on 07.08.2025.
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation
import DesignSystem

public struct CategoryModel: Identifiable, Sendable {

    public let id: Int
    public let imageURL: URL?
    public let title: String

    public init(id: Int, imageURL: URL?, title: String) {
        self.id = id
        self.imageURL = imageURL
        self.title = title
    }
}
