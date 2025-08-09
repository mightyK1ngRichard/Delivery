//
//  Created by Dmitriy Permyakov on 07.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation

public struct Popcat: Identifiable, Hashable, Sendable {

    public let id: Int
    public let title: String
    public let imageURL: URL?

    public init(id: Int, title: String, imageURL: URL?) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
}
